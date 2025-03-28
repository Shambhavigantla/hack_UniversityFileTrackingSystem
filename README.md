# Flutter Project

## Overview

This project is a cross-platform application built using the Flutter framework. It supports web, Android, and iOS platforms. The application leverages various packages to enhance its functionality and user interface.

## Tools Used

- **Framework:** Flutter (supports web, Android, and iOS applications)
- **IDE:** VSCodium
- **Design & Prototyping Tools:** penpot (Open source design tool)

## Packages Used

- `cupertino_icons: ^1.0.6`
- `get: ^4.7.2`
- `flutter_svg: ^2.0.5`
- `animated_text_kit: ^4.2.2`
- `glassmorphism: ^3.0.0`
- `google_fonts: ^5.1.0`

## Prerequisites

- Flutter SDK
- An IDE (e.g., VSCodium)

## Setup Instructions

1. **Create a Flutter Project:**
   - Open your terminal or command prompt.
   - Run the command: `flutter create your_project_name`

2. **Add the Library:**
   - Copy the `lib` folder from this repository into your created project.

3. **Add Required Packages:**
   - Open `pubspec.yaml` in your project.
   - Add the required packages under dependencies:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       cupertino_icons: ^1.0.6
       get: ^4.7.2
       flutter_svg: ^2.0.5
       animated_text_kit: ^4.2.2
       glassmorphism: ^3.0.0
       google_fonts: ^5.1.0
     ```
   - Specify the path to the assets folder:
     ```yaml
     flutter:
       assets:
         - assests/images/
         - assests/icons/
     ```

4. **Run the Application:**
   - Use the command: `flutter run -d chrome` to run the application in a web browser.



## Media

### Screenshots

### Video
