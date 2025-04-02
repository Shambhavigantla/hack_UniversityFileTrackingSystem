


## FULL-STACK Flutter Project - University File tracking System

## Overview

- A **Full-Stack Flutter-based web/mobile application** to streamline document request workflows between students and university administrators.

- Built with **FOSS tools**, ensuring transparency and cost-effectiveness. 

- **Real-Time** retrieval of data from **backend** (Not HardCoded)

- Different **Admins** can access and verify at each level. 

- It supports **web, Android, and iOS platforms**. 

- User friendly interface **responsiveness** for mobile, tablet and desktop screen-sizes.

## Tools Used

| Category       | FOSS Tools                 | 
|----------------|----------------------------|
| Frontend       | Flutter,                   | 
| Backend        | Node.js                    | 
| Database       | Firestore (Free Tier)      |
| Design         | Penpot                     | 
| Version Control| GitLab                     | 
| IDE            | VSCodium                   | 
| PPT            | LibreOffice                |

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
- Firebase

## Code Structure(MVC)

    
      lib/-->model/          # Data classes (e.g., `request.dart`)
          -->view/           # UI screens (e.g., `student_dashboard.dart`)
          -->controller/     # Dart logic (e.g., `request_controller.dart`)

## Setup Instructions

1. **Create a Flutter Project:**
   - Open your terminal or command prompt.
   - Run the command: `flutter create your_project_name`

2. **Add the Library:**
   - Copy the `lib` folder from this repository into your created project lib folder.

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
   - Use the command: `flutter run -d android` to run the application in a mobile.

