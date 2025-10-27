# Changelog - Excelerate Inquisit

## [1.1.0] - 2025-10-25

### Added
- **Screens Folder**: Created `lib/screens` and moved screen files (`LoginScreen.dart`, `HomeScreen.dart`, `CourseScreen.dart`, `ProgramDetail.dart`) for better organization.
- **JSON Data in Program Listing**: `lib/screens/CourseScreen.dart` fetches 6 courses (AI, Data Science, Cybersecurity, UI/UX, Cloud, Web Dev) from `assets/courses.json` with snackbar ("Courses loaded successfully!" or "Error loading courses").
- **Login Form Submission**: `lib/screens/LoginScreen.dart` uses Firebase Auth with feedback:
  - Invalid email: "Invalid email format."
  - Password < 6 characters: "Password must be at least 6 characters."
  - No user: "No user found for that email."
  - Wrong password: "Incorrect password."
  - Success: "Login successful!"
  - Password reset dialog: "Password reset link sent."
- **Navigation with Validations**: Secure navigation (LoginScreen → HomeScreen only on valid login; HomeScreen → CourseScreen → ProgramDetail).
- **Error Handling**: Image fallbacks (`placeholder.jpg`), JSON error snackbars, Firebase Auth error messages.
- `lib/screens` folder with screen files (`login_screen.dart`, `home_screen.dart`, `course_screen.dart`, `program_details_page.dart`).
- JSON data in `course_screen.dart` from `assets/courses.json` (6 courses).
- Login form in `login_screen.dart` with Firebase Auth feedback.
- Navigation validations (LoginScreen → HomeScreen requires login).
- Error handling: `placeholder.jpg`, JSON/Firebase snackbars.

### Changed
- Updated imports in `main.dart` and screen files to use `screens/` paths.
- Fixed `courses.json` path in `pubspec.yaml` to `assets/`.
- Updated `pubspec.yaml` with course images and `excelerate_logo.jpg`.

### Fixed
- Updated imports for `lib/screens/` paths.
- Added `constants.dart` for colors (kDarkBackground, kPrimaryText, etc.).
- Fixed `SignUpScreen` and `Program` class issues.

### To Do
- Implement search, account, message screens 
- Switch to Firestore once Firebase owner grants permissions.