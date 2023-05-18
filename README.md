# Food Ninja

Food Ninja is a food delivery app created using Flutter, Firebase, BLoC.

## Features

- Authentication
- Restaurants
- Food Menu
- Cart
- Order
- Profile
- Search
- Filter
- Payment (not implemented, just UI)
- Order History
- Map
- Chat
- Notification (not implemented, just UI)
- Call
- Rate
- Review
- Favorites
- Settings
- Dark Mode

## Screenshots

## Getting Started

For help getting started with Flutter, view Flutter's online
[documentation](https://flutter.dev/).

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
git clone https://github.com/ShokhrukhbekYuldoshev/Food-Ninja.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

This project uses Firebase. Go to https://firebase.google.com/ and create a new project. Then, create an Android app and follow the instructions to replace the `google-services.json` file. Note that, you'll need to create Firestore and Storage instances in Firebase Console.

**Step 4:**

Mapbox is used for map. Go to https://www.mapbox.com/ and create a new token. Then, create a file named `secrets.dart` in `lib` folder and add the following code:

```
const String MAPBOX_ACCESS_TOKEN = {YOUR_MAPBOX_ACCESS_TOKEN};
```

**Step 5:**
Run the project in Android Studio or Visual Studio Code.

## Design

[Figma Link](https://www.figma.com/file/CaPZO6Pu0cXl2ql4FdUT2p/Pixel-True---Food-Delivery-UI-Kit?t=5D9eRTLKxqB0TYJB-6)
