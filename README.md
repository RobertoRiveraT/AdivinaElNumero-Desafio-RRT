# AdivinaElNumero-Desafio-RRT - Flutter Challenge

An interactive number guessing game built with **Flutter Web**. Players must guess a secret number within a range that changes with each difficulty level. The app validates input, keeps track of every guess, and presents a mobile friendly interface.

---

## Features
- Multiple difficulty levels with dynamic ranges
- Central `GameController` to manage game state
- History of guesses with color-coded feedback
- Responsive UI suitable for web and mobile
- Basic widget test provided in `test/`

## Project Structure
```text
docs/                  - Design diagrams and screenshots
flutter_app_demo/
  lib/
    controllers/       - Game logic
    models/            - Data classes used throughout the app
    ui/                - Screens and reusable widgets
    utils/             - Utility helpers
  test/                - Widget tests
```

## Getting Started

### Requirements
- Flutter SDK installed (recommend `C:\dev\flutter` on Windows)
- Modern browser such as Chrome
- Git and optionally VSCode

### Setup
1. Clone the repository
   ```bash
git clone https://github.com/RobertoRiveraT/AdivinaElNumero-Desafio-RRT.git
cd AdivinaElNumero-Desafio-RRT/flutter_app_demo
   ```
2. Install dependencies
   ```bash
flutter pub get
   ```
3. Run on Chrome
   ```bash
flutter run -d chrome
   ```

### Mobile Simulation in Chrome
To test the app as if it were running on a phone:
1. Right-click the running app and select **Inspect** or press `Ctrl+Shift+I`
2. Click the **Toggle device toolbar** icon (or press `Ctrl+Shift+M`)
3. Choose a mobile device (e.g., Pixel 5, iPhone SE)
4. Set zoom to 100% for an accurate view

## Study Material
These resources helped shape the project and can be useful to learn more about Flutter:
- [How to Structure a Flutter Project (YouTube)](https://www.youtube.com/watch?v=8sAyPDLorek&t=3s)
- [Flutter Layout Fundamentals (Official Docs)](https://docs.flutter.dev/get-started/fundamentals/layout#understanding-layout-in-flutter)

## Video Demonstration
[Project Demonstration](https://drive.google.com/file/d/1yknblM6vfuxDzgTI5FADm1ckjAiY3YUX/view?usp=sharing)
