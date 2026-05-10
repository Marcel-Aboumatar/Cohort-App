import asyncio
from playwright.async_api import async_playwright, expect

async def course_output_formatter(page1, i):
    row_locator = page1.locator(".esg-table-body__row").nth(i)
    status = await page1.locator(".esg-table-body__td").nth(0).inner_text()
    
    title = await row_locator.locator(".esg-table-body__td").nth(1).inner_text()
    code, name = str(title).split(": ")
    
    credits = await row_locator.locator(".esg-table-body__td").nth(2).inner_text()
    credits = str(credits[:4]).split()[0]

    time = str(await row_locator.locator(".esg-table-body__td").nth(3).inner_text())
    formatted_time = time.split("\n")
    print(formatted_time)
    course_sections = []
    for j in range(0,len(formatted_time),2):
        type_days_time = formatted_time[j]
        course_type = type_days_time
        days = type_days_time
        time_range = type_days_time
        # course_duration = formatted_time[j+1]
        # be sure to use the max_splits part of str.split
        # course_type, days, time_range =  formatted_time[j].split(" ", 3)
        
        course_sections.append({"course_type":course_type, "days": days, "time_range": time_range,"course_duration":formatted_time[j+1]})
    # can guarentee the course duration for the term

    location = await row_locator.locator(".esg-table-body__td").nth(4).inner_text()
    location_list = location.split("\n")
    instructor = await row_locator.locator(".esg-table-body__td").nth(5).inner_text()
    return {"status":status, "title":title, "code":code, "name":name, "credits":credits,  "location_list":location_list, "course_sections":course_sections, "instructor":instructor}


async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        page = await browser.new_page()
        page.set_default_timeout(0)
        await page.goto("https://colleague-ss.uoguelph.ca/Student")
        await page.wait_for_url("https://login.microsoftonline.com/**")
        await page.get_by_role("button", name="Open the navigation menu").click()
        await page.get_by_role("button", name="Academics").click()
        await page.get_by_role("button", name="Student Planning").click()
        await page.get_by_role("link", name="Plan, Schedule, Register &").click()
        await page.get_by_role("button", name="Show the previous term").click()
        async with page.expect_popup() as page1_info:
            await page.locator("#print-schedule").click()
        page1 = await page1_info.value
        await page1.wait_for_load_state("domcontentloaded")
        row_count = await page1.locator(".esg-table-body__row").count()
        print(row_count)
        outputs = []
        for i in range(row_count):
            dict_values = await course_output_formatter(page1, i)
            outputs.append(dict_values)
            # outputs.update({status,course_code, course_name, credits,lecture_values, course_duration,location_list,instructor))
        for i in outputs:
            print(i)
        
        await page1.pause()

asyncio.run(main())