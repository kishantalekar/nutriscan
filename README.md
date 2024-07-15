# Nutriscan

## Overview

Nutriscan is an application designed to provide users with detailed nutritional and ingredient information by scanning the barcode of food products. The app aims to simplify the process of making informed dietary choices and empower users to better manage their nutritional intake.

## Features

- **Barcode Scanning**: By simply scanning the barcode of a food item, Nutriscan instantly generates data on its ingredients, nutritional content, allergens, and more.
- **User-Friendly Interface**: Presents nutritional information in an easily understandable manner.
- **Expiry Reminder**: Keep track of food items and get reminders before they expire.
- **History Tracking**: Stores scanned items in the user's history using Firebase.

## Technologies Used

- **Frontend**: Flutter
- **Backend**: Firebase

## Project Structure

The project consists of the following main folders:

- `lib`: Contains the Dart code for the Flutter application.
- `assets`: Contains images and other asset files used in the app.
- `android`: Android-specific files and configurations.
- `ios`: iOS-specific files and configurations.

## Setup and Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/yourusername/nutriscan.git
   ```

2. Navigate to the project directory:

   ```sh
   cd nutriscan
   ```

3. Install Flutter dependencies:

   ```sh
   flutter pub get
   ```

4. Set up Firebase:

   - Follow the official [Firebase documentation](https://firebase.google.com/docs/flutter/setup) to configure Firebase for both Android and iOS.

5. Run the app on your preferred device or emulator:
   ```sh
   flutter run
   ```

## Screens

- **Login**: User authentication screen.
  ![Login](assets/project/login.png)
- **Register**: User registration screen.
  ![Register](assets/project/register.png)
- **Home (Customer)**: Main interface for scanning barcodes and viewing nutritional information.
  ![Home](assets/project/scannedHome.png)
- **Reminder**: Screen to manage reminders for food items.
  ![Reminder](assets/project/reminder.png)
- **Reminder List**: Screen to view the list of reminders.
  ![Reminder List](assets/project/reminder_list.png)
- **Product**: Screen to view detailed information about a product.
  ![Product](assets/project/product.png)
- **Product1**: Another screen variant for viewing product details.
  ![Product1](assets/project/product1.png)
- **Admin Dashboard**: Admin interface for managing products.
  ![Admin Dashboard](assets/project/admin_dashboard.png)
- **Add Product**: Admin screen to add new products.
  ![Add Product](assets/project/add_product.png)
- **Add Product1**: Another variant of the admin screen for adding new products.
  ![Add Product1](assets/project/add_product1.png)

## Contact Information

For any questions or support related to the project, please contact:

- LinkedIn: [Kishantalekar](https://www.linkedin.com/in/kishan-talekar-2613b8260/)
- Twitter: [Kishantalekar](https://x.com/KishanTalekar)
