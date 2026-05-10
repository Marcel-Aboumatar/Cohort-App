# CohortApp

CohortApp is a full-stack student social and academic networking platform that helps users **discover classmates, manage courses, build connections, and visualize their academic schedule in one place**.

It transforms static course schedules into a **social graph of students**, enabling discovery, collaboration, and easier coordination among peers.

---

## Live Access
To access CohortApp, download the project and in the fronend directory run $flutter run

To access the backend, visit the deployed ngrok site: [https://unattired-jackson-undaughterly.ngrok-free.dev](https://unattired-jackson-undaughterly.ngrok-free.dev)

---

## Inspiration

University students often struggle to:
- Find classmates in their courses
- Coordinate study groups
- Track schedules across multiple systems
- Connect outside of class

CohortApp was built to solve this by turning **course enrollment data into a social discovery system**, allowing users to connect based on shared academic experiences.

---

## Features

### Authentication
- Secure signup and login system
- Profile creation with:
  - Name
  - Email
  - Major
  - Bio
- Optional integration with Outlook/WebAdvisor for schedule import

---

### Discover
- Find **random classmates in your courses**
- View shared classes with other students
- Send friend requests instantly

---

### Friends System
- View current friends list
- Accept or reject friend requests
- Search users via email
- View profiles of connected users

---

### Classes
- Displays all courses in your schedule
- Shows:
  - Course sections
  - Class times
  - Friends enrolled in each course
- Import courses manually or via WebAdvisor sync

---

### Calendar
- Automatically generated academic calendar
- Displays all class events in **24-hour format**
- Aggregates schedule across all courses

---

### Import System
- One-click login to Outlook/WebAdvisor
- Automatically pulls course schedule data
- Converts schedule into structured course objects

---

### Profile
- Editable user profile (name, major, bio)
- Privacy controls:
  - Make profile discoverable / undiscoverable
- Account management:
  - Sign out
  - Delete account

---

## System Architecture

CohortApp is built as a full-stack system:

- **Frontend:** Flutter (mobile/web UI)
- **Backend:** Flask / Python API
- **Database:** MongoDB
- **Automation:** Playwright (WebAdvisor scraping)
- **Auth:** Email + hashed password system with salt
- **Deployment:** ngrok tunneling for live access

---

## Core Data Model

Each user stores:

- Profile information
- Friend relationships
- Course schedules
