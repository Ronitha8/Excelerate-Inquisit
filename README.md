# 📱 Excelerate Inquisit    

**Program:** Excelerate Mobile App Development Internship  
**Team:** Team 35  
**Platform:** Mobile (Flutter)  
**Repository Manager:** Ronitha Sanem  

---    

## 🚀 Introduction    
Excelerate Inquisit is a mobile app designed to extend the Excelerate learning experience beyond the website. It's set up to reflect some parts of the main platform, giving users direct access to their profiles in a more simplified way for faster navigation and a more engaging user experience.  

---    

## 🧩 Core Features
- **Login & Authentication:** Firebase Auth with email/password, feedback for invalid email, password < 6 characters ("Password must be at least 6 characters"), and success ("Login successful"). Includes Google/Facebook placeholders and password reset dialog.
- **Dashboard:** Shows learning plan, enrolled courses, and Excelerate logo (`assets/images/excelerate_logo.jpg`).
- **Program Listing:** Displays 6 rich courses (AI, Data Science, Cybersecurity, UI/UX, Cloud, Web Dev) from `assets/courses.json` with snackbar feedback ("Courses loaded successfully!" or "Error loading courses").
- **Program Detail:** Shows course details (title, description, duration, level, instructor, image) with `placeholder.jpg` fallback.
- **Search Button:** For searching courses/internships (pending implementation).
- **Message Screen:** For notifications and messages (pending implementation).
- **Profile Page:** For user info, settings, privacy, help, logout (pending implementation).

---    

## 🧰 Tools & Technologies
- **Framework:** Flutter
- **Language:** Dart
- **Authentication:** Firebase Auth
- **Data Source:** Local JSON (`assets/courses.json`)
- **Design Tool:** Figma
- **Version Control:** GitHub
- **Dependencies:** `google_fonts: ^6.2.1`, `font_awesome_flutter: ^11.0.0`, `firebase_core: ^3.6.0`, `firebase_auth: ^5.3.1`

---

## Setup
1. Clone the repository: `git clone https://github.com/CharisseEerie/excelerate-inquisit.git`
2. Install dependencies: `flutter pub get`
3. Configure Firebase:
   - Add `google-services.json` to `android/app` (for Android).
   - Update `lib/main.dart` with FirebaseOptions (for web).
4. Run the app: `flutter run -d chrome`

---

## Assets
- Images: `assets/images/` (e.g., `excelerate_logo.png`, `ai.jpg`, `placeholder.jpg`)
- Data: `assets/courses.json` (program details)

---

## Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  google_fonts: ^6.2.1
  font_awesome_flutter: ^10.12.0

---

## 🎥 App Demo Video Links
[🎥 Watch App Demo Video](https://drive.google.com/file/d/1tvOYKwBXqjRwf4HtQb6beYSVaaCAoNdf/view?usp=drivesdk)

[🎬 Watch UPDATED App Demo Video](https://drive.google.com/file/d/1Oke2u329lDAGPYFbgaGrhosjdoyDadxh/view?usp=drive_link)

---

## 📸 Screenshots

### 🔹 Login Screen  
![Login Screen](screenshots/login_screen.png)

### 🔹 Home Screen  
![Home Screen](screenshots/home_screen.png)

### 🔹 Course Screen  
![Course Screen](screenshots/course_screen.png)

### 🔹 Filter Screen  
![Filter Screen](screenshots/filter_screen.png)

### 🔹 Notification Screen  
![Notification Screen](screenshots/notification_screen.png)

### 🔹 Signup Screen  
![Signup Screen](screenshots/signup_screen.png)

### 🔹 Account Screen  
![Account Screen](screenshots/account_screen.png)

---   


## 📊 System Requirements    
**Functional Requirements:**    
- User authentication (mocked)  
- Dashboards for learners  
- Course & evaluation modules  

**Non-functional Requirements:**    
- Smooth performance  
- Mobile responsiveness  
- Dark mode UI  
- Time zone-friendly notifications  

---    

## 👩‍💻 Contributors    
- **Charissa Sarah** – Team Lead & developer
- **Fares Salah** – Project manager & developer 
- **Barakat Salaudeen** – Project Scribe & developer
- **Ronitha Sanem** – Developer  
- **Sara Sameh** - Developer
- **Samin** - Developer

---    

## 🏁 Conclusion    
Excelerate Inquisit combines usability, accessibility, and interactivity to make mobile learning more intuitive and rewarding.  
This project demonstrates our team’s understanding of full-cycle mobile app development — from UI design to documentation and GitHub collaboration.  
