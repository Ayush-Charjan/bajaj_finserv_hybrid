# Bajaj Finserv Demo App

A simplified Flutter demo app that replicates the basic structure of the Bajaj Finserv mobile app for learning purposes.

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue)
![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 🚀 Quick Start

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0.0 or higher)
- [Git](https://git-scm.com/downloads)
- An IDE: [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation Steps

1. **Clone the repository**
```bash
git clone https://github.com/Ayush-Charjan/bajaj-finserv-demo.git
cd bajaj-finserv-demo
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**

Choose your preferred platform:

```bash
# For Android/iOS (requires emulator or device)
flutter run

# For Windows
flutter run -d windows

# For Chrome browser (fastest for testing)
flutter run -d chrome

# For Edge browser
flutter run -d edge
```

4. **Login to the app**
- Use any email address (must contain @)
- Use any password (minimum 6 characters)
- Example: `test@example.com` / `password123`

That's it! You're ready to explore the app. 🎉

## Features

### Screens
- **Login Screen**: User authentication with email and password
- **Home Dashboard**: Greeting, credit card widget, and feature grid
- **Loans Screen**: View and manage all loans with filtering options
- **EMI Screen**: Track upcoming EMI payments
- **Profile Screen**: User information and app settings

### Key Functionalities
- Bottom navigation bar for easy screen switching
- Clean Material Design UI with cards and icons
- Mock data service (no API calls required)
- Beginner-friendly code with comments
- Organized folder structure

## Project Structure

```
lib/
├── models/              # Data models
│   ├── user.dart
│   ├── loan.dart
│   ├── emi.dart
│   └── feature_item.dart
├── services/            # Mock data services
│   └── mock_data_service.dart
├── screens/             # All screen files
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── loans_screen.dart
│   ├── emi_screen.dart
│   ├── profile_screen.dart
│   └── main_navigation_screen.dart
├── widgets/             # Reusable widgets
│   ├── credit_card_widget.dart
│   ├── feature_grid_item.dart
│   ├── loan_card.dart
│   └── emi_card_widget.dart
└── main.dart           # App entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extension

### Installation

1. Clone or download this project
2. Navigate to the project directory
3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

### Login Credentials
For demo purposes, you can use any email and password (minimum 6 characters) to login.

## Learning Points

This app demonstrates:
- **State Management**: Using StatefulWidget for interactive screens
- **Navigation**: Route-based navigation and BottomNavigationBar
- **Widget Composition**: Building complex UIs from simple widgets
- **Code Organization**: Separating models, services, screens, and widgets
- **Material Design**: Using Flutter's Material Design components
- **Form Validation**: Input validation for login forms
- **Mock Data**: Creating and using mock data services

## Customization

You can customize the app by:
- Modifying colors in `main.dart` theme configuration
- Adding more features to the feature grid
- Creating additional loan types or EMI cards
- Implementing real API integration
- Adding more screens and functionalities

## 🛠️ Troubleshooting

### Common Issues

**"No devices found"**
- Run `flutter devices` to see available devices
- For mobile: Start an Android emulator or iOS simulator
- For desktop: Use `-d windows`, `-d chrome`, or `-d edge`

**Build errors**
```bash
flutter clean
flutter pub get
flutter run
```

**Platform not supported**
```bash
flutter create .
flutter pub get
flutter run -d [platform]
```

## 🤝 Contributing

This is a learning project, but contributions are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📚 Learning Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Material Design](https://material.io/design)

## 📝 Future Enhancements

- Implement state management (Provider, Riverpod, or Bloc)
- Add real API integration
- Include authentication with Firebase
- Add biometric authentication
- Implement push notifications
- Add payment gateway integration
- Create loan application flow
- Add charts and analytics

## 📄 License

This project is created for educational purposes and is free to use and modify for learning.

## 👨‍💻 Author

**Ayush Charjan**
- GitHub: [@Ayush-Charjan](https://github.com/Ayush-Charjan)

## ⭐ Show Your Support

Give a ⭐️ if this project helped you learn Flutter!

---

**Note:** This is a demo app for learning purposes only. All data is mock data stored in memory. No actual backend or payment processing is implemented.
