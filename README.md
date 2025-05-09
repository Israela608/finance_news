# Finance News

A Flutter application designed to provide users with the latest finance news. The app includes features such as user authentication, notifications, and a custom news web view.

## Features

- **User Registration**: Sign-up functionality with form validation.
- **Notifications**: Request notification permissions and show in-app alerts.
- **WebView**: Display web pages within the app.
- **Responsive Design**: Designed to work across both Android and iOS devices.
- **Custom Launcher Icons**: App icons are configured for various platforms, including Android, iOS, web, and Windows.

## Screenshots

### 1. User Registration Screen
![Screenshot_20250509_020027](https://github.com/user-attachments/assets/281707e3-3924-47bd-8400-153b0a20802e)


### 2. Allow Notifications Screen
![Screenshot_20250509_020039](https://github.com/user-attachments/assets/a606874b-98a3-4a1b-bcee-7cae70406648)


### 3. News Screen
![Screenshot_20250509_015656](https://github.com/user-attachments/assets/4611ac4a-7fd6-4232-9505-fd7f6dc8a495)


### 4. News Detail WebView
![Screenshot_20250509_015742](https://github.com/user-attachments/assets/d0a328d9-96b3-497e-882b-0a33c1c5bc06)


## Setup Instructions

### Prerequisites

1. **Flutter SDK**: Ensure you have Flutter installed on your machine. If not, follow the [installation guide](https://flutter.dev/docs/get-started/install).
2. **Android Studio/VS Code**: Install an IDE of your choice (Android Studio or Visual Studio Code) for Flutter development.
3. **Xcode (for iOS)**: If you are developing for iOS, make sure you have Xcode installed.

### Steps to Run

**Clone the repository:**
```bash
git clone https://github.com/Israela608/finance_news.git
```

```bash
cd finance_news
```

**Install dependencies:**
```bash
flutter pub get
```

**Configure the app icons:**
Add your app_logo.png image to the assets folder.

Update the flutter_launcher_icons configuration in pubspec.yaml.

Run the following command to generate icons:

```bash
flutter pub run flutter_launcher_icons:main
```
Run the app:

```bash
flutter run
```
For iOS, ensure that you have Xcode installed and use:
```bash
flutter run --ios
```

For Android, make sure you have an Android emulator or physical device connected, then use:
```bash
flutter run --android

```

## Code Structure
```
lib/common/: Custom widgets like text fields, buttons, and loading indicators.

lib/core/: Utility functions, including validators, app styles, colors and helpers.

lib/data/: Contains models used for user data and API responses, services, repos.

lib/modules/: Contains the main screens and View architecture.
```

## Dependencies
**flutter_launcher_icons:** To generate app icons for various platforms.

**hooks_riverpod:** For state management.

**webview_flutter:** To display web pages within the app.

**permission_handler:** To request and check permissions for notifications.

## Contributing
Feel free to fork this repository and make pull requests. If you find any bugs or have feature suggestions, please create an issue.

## License
This project is licensed under the MIT License - see the LICENSE file for details
