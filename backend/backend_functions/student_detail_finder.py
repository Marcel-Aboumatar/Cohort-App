import asyncio
from playwright.async_api import async_playwright, Cookie, Playwright
async def day_to_matrix_converter(day_string: str):
    splitted_string = "".join(" " + c if c.isupper() else c for c in day_string).strip()
    splitted_string = splitted_string.split()
    matrix = [0,0,0,0,0,0,0]

    for i in splitted_string:
        match(i):
            case "Su":
                matrix[0] = 1
            case "Th":
                matrix[4] = 1
            case "Sa":
                matrix[6] = 1
            case "M":
                matrix[1] = 1
            case "T":
                matrix[2] = 1
            case "W":
                matrix[3] = 1
            case "F":
                matrix[5] = 1
    return matrix

async def course_output_formatter(page1, i):
    row_locator = page1.locator(".esg-table-body__row").nth(i)
    status = await page1.locator(".esg-table-body__td").nth(0).inner_text()
    
    title = await row_locator.locator(".esg-table-body__td").nth(1).inner_text()
    code, name = str(title).split(": ", maxsplit=1)
    
    credits = await row_locator.locator(".esg-table-body__td").nth(2).inner_text()
    credits = str(credits[:4]).split()[0]

    time = str(await row_locator.locator(".esg-table-body__td").nth(3).inner_text())
    formatted_time = time.split("\n")
    course_sections = []
    for j in range(0,len(formatted_time),2):
        type_days_time = formatted_time[j].split(maxsplit=2)
        if type_days_time[1] == "TBD":
            course_type = type_days_time[0]
            days = "[0,0,0,0,0,0,0]"
            time_range = "TBD"
        else:
            course_type = type_days_time[0]
            days = await day_to_matrix_converter(type_days_time[1])
            time_range = type_days_time[2]
        
        course_sections.append({"course_type":course_type, "days": days, "time_range": time_range,"course_duration":formatted_time[j+1]})
    # can guarentee the course duration for the term

    location = await row_locator.locator(".esg-table-body__td").nth(4).inner_text()
    location_list = location.split("\n")
    instructor = await row_locator.locator(".esg-table-body__td").nth(5).inner_text()
    return {"status":status, "code":code, "name":name, "credits":credits,  "location_list":location_list, "course_sections":course_sections, "instructor":instructor}


async def main(username, password):

    async with async_playwright() as p:
        browser_instance = await p.chromium.launch(headless=False)
        current_context = await browser_instance.new_context()
        page = await current_context.new_page()
        page.set_default_timeout(0)
        await page.goto("https://colleague-ss.uoguelph.ca/Student")
        await page.wait_for_url("https://login.microsoftonline.com/**")
        await page.get_by_role("textbox").fill(username)
        await page.get_by_role("button", name="Next").click()
        await page.locator('id=i0118').fill(password)
        await page.get_by_role("button", name="Sign in").click()
        code = await page.locator("id=idRichContext_DisplaySign").inner_text()
        with open("code.txt", "w+") as file:
            file.write(code)
        await page.wait_for_url("https://colleague-ss.uoguelph.ca/**", wait_until="load")
        await page.goto("https://colleague-ss.uoguelph.ca/Student")
        await page.get_by_role("button", name="Open the navigation menu").click()
        await page.get_by_role("button", name="Academics").click()
        await page.get_by_role("button", name="Student Planning").click()
        await page.get_by_role("link", name="Plan, Schedule, Register &").click()
        async with page.expect_popup() as page1_info:
            await page.locator("#print-schedule").click()
        page1 = await page1_info.value
        await page1.wait_for_load_state("domcontentloaded")
        row_count = await page1.locator(".esg-table-body__row").count()
        outputs = []
        for i in range(row_count):
            dict_values = await course_output_formatter(page1, i)
            outputs.append(dict_values)
        return outputs
    
def run_playwright(username,password):
    return asyncio.run(main(username, password))