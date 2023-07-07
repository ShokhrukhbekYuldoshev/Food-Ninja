# Food Ninja

Food Ninja is a food delivery app created using Flutter, Firebase, BLoC.

## Features

- Authentication
- Restaurants
- Food Menu
- Search
- Filter (not implemented)
- Pagination
- Cart
- Order
- Order History
- Profile
- Favorites
- Payment (just UI)
- Map
- Chat
- Rate
- Review
- Dark Mode
- Settings
- Reset Password
- Notification (just UI)
- Voucher (just UI)

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

## Screenshots

<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/82f7adb4-7615-4e61-bb36-98fcf63345fb" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/caa56940-163c-4f9f-8b34-e49263e75776" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/a49f5482-2ad2-4015-a036-9b7cf6f44164" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/45289d1f-7c71-4f28-9056-2b9e2a581dc7" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/16cd42d1-b358-484e-9a9b-4e34d889ed39" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/4dc1be24-5886-4c9f-a301-1423f984f584" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/4ae70fd2-e131-4d19-acd6-c16335d51e61" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/bda14b62-c886-49af-92f2-c2b73166ea76" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/2760671f-73d6-4600-8543-58766e546d5e" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/5c2eefb1-b769-498a-bac1-ef0ae54d0793" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/eb2a88c5-c224-4d46-9de6-83c223ac1e1c" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/d5fbbde5-93f7-4616-9318-897b0449c373" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/8b74fb15-ec2c-48c2-8183-4f0dba841836" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/20d5b83d-f602-40b0-9587-367600462399" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/1e0512c2-c2ca-4188-a756-e8a8f2049dbf" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/43cb85b7-24e0-4293-9927-6bd27265e60d" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/500e800f-281f-41fe-b90e-bc06349e7653" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/f3100362-d349-48da-a305-883be2c486e3" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/0be05079-825e-4ba3-ae0a-91282a698838" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/6a0a7647-fad0-4351-8b49-e7c928d0f0e4" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/79dca987-12e4-4c01-bb40-283335af22ff" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/fd4e8988-800c-4721-b816-fb3939a31d73" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/fe3dd9da-7228-4fc4-a9e8-3bd863668c95" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/e572065c-7876-473f-80b1-9d8a9ce7e921" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/d51908ce-ac9d-462e-99b7-40616c9b22cc" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/c490355f-fa1c-431c-a96f-a5c4998c3e08" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/3330cddd-4fb7-47a3-8dbc-2dab40481217" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/44c605ad-1140-4da8-9ff9-1a317ef44125" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/3429e289-1695-4f58-8c1d-0589257f5ac1" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/7c27ea86-cace-4579-b2ba-c2468e13f272" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/0091594f-f548-4c5a-a066-c639a37daca5" height="500">
<img src="https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/4f91faf7-9b38-40f3-93fc-f9eb8501d49b" height="500">

## [Dependencies](pub.dev)

- [bloc](https://pub.dev/packages/bloc)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [dio](https://pub.dev/packages/dio)
- [equatable](https://pub.dev/packages/equatable)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_storage](https://pub.dev/packages/firebase_storage)
- [flutter](https://pub.dev/packages/flutter)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_map](https://pub.dev/packages/flutter_map)
- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)
- [flutter_slidable](https://pub.dev/packages/flutter_slidable)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [geolocator](https://pub.dev/packages/geolocator)
- [hive](https://pub.dev/packages/hive)
- [hive_flutter](https://pub.dev/packages/hive_flutter)
- [image_picker](https://pub.dev/packages/image_picker)
- [intl](https://pub.dev/packages/intl)
- [latlong2](https://pub.dev/packages/latlong2)
- [shimmer](https://pub.dev/packages/shimmer)

## 📝 License

This project is [MIT](LICENSE) licensed.

## 👨🏽‍💻 Author

👤 **Shokhrukhbek Yuldoshev**

- Github: [@ShokhrukhYuldoshev](https://github.com/ShokhrukhbekYuldoshev)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/issues)

## Show your support

Give a ⭐️ if you like this project!
