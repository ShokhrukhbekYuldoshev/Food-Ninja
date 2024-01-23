# 🍴🥷 Food Ninja

## 📝 Description

Food Ninja is a food delivery app created using Flutter, Firebase, BLoC.

## 📱 Platforms

-   Android
-   iOS

## ✨ Features

-   [x] Authentication
-   [x] Restaurants
-   [x] Food Menu
-   [x] Search
-   [ ] Filter
-   [x] Pagination
-   [x] Cart
-   [x] Order
-   [x] Order History
-   [x] Profile
-   [x] Favorites
-   [ ] Payment (just UI)
-   [x] Map
-   [x] Chat
-   [x] Rate
-   [x] Review
-   [x] Dark Mode
-   [x] Settings
-   [x] Reset Password
-   [ ] Notification (just UI)
-   [ ] Promo Codes (just UI)

## 📦 Installation

### Prerequisites

-   Flutter
-   Android Studio / Xcode

### Setup

1. Clone the repo

    ```sh
    git clone
    ```

2. Install dependencies

    ```sh
    dart pub get
    ```

3. This project uses Firebase. Go to https://firebase.google.com/ and create a new project. Then, create an Android app and follow the instructions to replace the `google-services.json` file. Note that, you'll need to create Firestore and Storage instances in Firebase Console.

4. Mapbox is used for map. Go to https://www.mapbox.com/ and create a new token. Then, create a file named `secrets.dart` in `lib/src` folder and add the following code:

    ```dart
    const String mapboxAccessToken = {YOUR_MAPBOX_ACCESS_TOKEN};
    ```

5. Run the app

    ```sh
    flutter run
    ```

## Design

[Figma Link](https://www.figma.com/file/CaPZO6Pu0cXl2ql4FdUT2p/Pixel-True---Food-Delivery-UI-Kit?t=5D9eRTLKxqB0TYJB-6)

## Screenshots

<!-- variables -->

<!-- Variables -->

[screenshot1]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/82f7adb4-7615-4e61-bb36-98fcf63345fb 'Screenshot 1'
[screenshot2]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/caa56940-163c-4f9f-8b34-e49263e75776 'Screenshot 2'
[screenshot3]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/a49f5482-2ad2-4015-a036-9b7cf6f44164 'Screenshot 3'
[screenshot4]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/45289d1f-7c71-4f28-9056-2b9e2a581dc7 'Screenshot 4'
[screenshot5]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/16cd42d1-b358-484e-9a9b-4e34d889ed39 'Screenshot 5'
[screenshot6]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/4dc1be24-5886-4c9f-a301-1423f984f584 'Screenshot 6'
[screenshot7]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/4ae70fd2-e131-4d19-acd6-c16335d51e61 'Screenshot 7'
[screenshot8]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/bda14b62-c886-49af-92f2-c2b73166ea76 'Screenshot 8'
[screenshot9]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/2760671f-73d6-4600-8543-58766e546d5e 'Screenshot 9'
[screenshot10]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/5c2eefb1-b769-498a-bac1-ef0ae54d0793 'Screenshot 10'
[screenshot11]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/eb2a88c5-c224-4d46-9de6-83c223ac1e1c 'Screenshot 11'
[screenshot12]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/d5fbbde5-93f7-4616-9318-897b0449c373 'Screenshot 12'
[screenshot13]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/8b74fb15-ec2c-48c2-8183-4f0dba841836 'Screenshot 13'
[screenshot14]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/20d5b83d-f602-40b0-9587-367600462399 'Screenshot 14'
[screenshot15]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/1e0512c2-c2ca-4188-a756-e8a8f2049dbf 'Screenshot 15'
[screenshot16]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/43cb85b7-24e0-4293-9927-6bd27265e60d 'Screenshot 16'
[screenshot17]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/500e800f-281f-41fe-b90e-bc06349e7653 'Screenshot 17'
[screenshot18]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/f3100362-d349-48da-a305-883be2c486e3 'Screenshot 18'
[screenshot19]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/0be05079-825e-4ba3-ae0a-91282a698838 'Screenshot 19'
[screenshot20]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/6a0a7647-fad0-4351-8b49-e7c928d0f0e4 'Screenshot 20'
[screenshot21]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/79dca987-12e4-4c01-bb40-283335af22ff 'Screenshot 21'
[screenshot22]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/fd4e8988-800c-4721-b816-fb3939a31d73 'Screenshot 22'
[screenshot23]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/fe3dd9da-7228-4fc4-a9e8-3bd863668c95 'Screenshot 23'
[screenshot24]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/e572065c-7876-473f-80b1-9d8a9ce7e921 'Screenshot 24'
[screenshot25]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/d51908ce-ac9d-462e-99b7-40616c9b22cc 'Screenshot 25'
[screenshot26]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/c490355f-fa1c-431c-a96f-a5c4998c3e08 'Screenshot 26'
[screenshot27]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/3330cddd-4fb7-47a3-8dbc-2dab40481217 'Screenshot 27'
[screenshot28]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/44c605ad-1140-4da8-9ff9-1a317ef44125 'Screenshot 28'
[screenshot29]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/3429e289-1695-4f58-8c1d-0589257f5ac1 'Screenshot 29'
[screenshot30]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/7c27ea86-cace-4579-b2ba-c2468e13f272 'Screenshot 30'
[screenshot31]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/0091594f-f548-4c5a-a066-c639a37daca5 'Screenshot 31'
[screenshot32]: https://github.com/ShokhrukhbekYuldoshev/Food-Ninja/assets/72590392/4f91faf7-9b38-40f3-93fc-f9eb8501d49b 'Screenshot 32'

<!-- Table -->

|         Screenshot 1         |         Screenshot 2         |         Screenshot 3         |
| :--------------------------: | :--------------------------: | :--------------------------: |
| ![Screenshot 1][screenshot1] | ![Screenshot 2][screenshot2] | ![Screenshot 3][screenshot3] |

|         Screenshot 4         |         Screenshot 5         |         Screenshot 6         |
| :--------------------------: | :--------------------------: | :--------------------------: |
| ![Screenshot 4][screenshot4] | ![Screenshot 5][screenshot5] | ![Screenshot 6][screenshot6] |

|         Screenshot 7         |         Screenshot 8         |         Screenshot 9         |
| :--------------------------: | :--------------------------: | :--------------------------: |
| ![Screenshot 7][screenshot7] | ![Screenshot 8][screenshot8] | ![Screenshot 9][screenshot9] |

|         Screenshot 10          |         Screenshot 11          |         Screenshot 12          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 10][screenshot10] | ![Screenshot 11][screenshot11] | ![Screenshot 12][screenshot12] |

|         Screenshot 13          |         Screenshot 14          |         Screenshot 15          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 13][screenshot13] | ![Screenshot 14][screenshot14] | ![Screenshot 15][screenshot15] |

|         Screenshot 16          |         Screenshot 17          |         Screenshot 18          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 16][screenshot16] | ![Screenshot 17][screenshot17] | ![Screenshot 18][screenshot18] |

|         Screenshot 19          |         Screenshot 20          |         Screenshot 21          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 19][screenshot19] | ![Screenshot 20][screenshot20] | ![Screenshot 21][screenshot21] |

|         Screenshot 22          |         Screenshot 23          |         Screenshot 24          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 22][screenshot22] | ![Screenshot 23][screenshot23] | ![Screenshot 24][screenshot24] |

|         Screenshot 25          |         Screenshot 26          |         Screenshot 27          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 25][screenshot25] | ![Screenshot 26][screenshot26] | ![Screenshot 27][screenshot27] |

|         Screenshot 28          |         Screenshot 29          |         Screenshot 30          |
| :----------------------------: | :----------------------------: | :----------------------------: |
| ![Screenshot 28][screenshot28] | ![Screenshot 29][screenshot29] | ![Screenshot 30][screenshot30] |

|         Screenshot 31          |         Screenshot 32          |
| :----------------------------: | :----------------------------: |
| ![Screenshot 31][screenshot31] | ![Screenshot 32][screenshot32] |

## 📚 Dependencies

| Name                                                                      | Version | Description                                                                                                                                                       |
| ------------------------------------------------------------------------- | ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [bloc](https://pub.dev/packages/bloc)                                     | 8.1.2   | A predictable state management library                                                                                                                            |
| [cloud_firestore](https://pub.dev/packages/cloud_firestore)               | 4.14.0  | Cloud Firestore Plugin for Flutter                                                                                                                                |
| [dio](https://pub.dev/packages/dio)                                       | 5.4.0   | A powerful Http client for Dart, which supports Interceptors                                                                                                      |
| [equatable](https://pub.dev/packages/equatable)                           | 2.0.5   | Simplify Equality Comparisons                                                                                                                                     |
| [firebase_auth](https://pub.dev/packages/firebase_auth)                   | 4.16.0  | Firebase Authentication Plugin for Flutter                                                                                                                        |
| [firebase_core](https://pub.dev/packages/firebase_core)                   | 2.24.2  | Core Firebase Flutter SDK                                                                                                                                         |
| [firebase_storage](https://pub.dev/packages/firebase_storage)             | 11.6.0  | Firebase Storage Plugin for Flutter                                                                                                                               |
| [flutter_bloc](https://pub.dev/packages/flutter_bloc)                     | 8.1.3   | Flutter Widgets that make it easy to implement BLoC design patterns                                                                                               |
| [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | 0.13.1  | A package that provides icons for Flutter apps                                                                                                                    |
| [flutter_map](https://pub.dev/packages/flutter_map)                       | 6.1.0   | Interactive Map for Flutter                                                                                                                                       |
| [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)         | 4.0.1   | A Flutter widget for rating bar                                                                                                                                   |
| [flutter_slidable](https://pub.dev/packages/flutter_slidable)             | 3.0.1   | A Flutter widget that can be slid horizontally or vertically                                                                                                      |
| [flutter_svg](https://pub.dev/packages/flutter_svg)                       | 2.0.9   | SVG Rendering Library for Flutter                                                                                                                                 |
| [geolocator](https://pub.dev/packages/geolocator)                         | 10.1.0  | Flutter Geolocation Plugin                                                                                                                                        |
| [hive](https://pub.dev/packages/hive)                                     | 2.2.3   | NoSQL database in pure Dart                                                                                                                                       |
| [hive_flutter](https://pub.dev/packages/hive_flutter)                     | 1.1.0   | Hive Flutter Adapter                                                                                                                                              |
| [image_picker](https://pub.dev/packages/image_picker)                     | 1.0.7   | Flutter Image Picker                                                                                                                                              |
| [intl](https://pub.dev/packages/intl)                                     | 0.19.0  | Internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text. |
| [latlong2](https://pub.dev/packages/latlong2)                             | 0.9.0   | Latitude and longitude coordinates                                                                                                                                |
| [shimmer](https://pub.dev/packages/shimmer)                               | 3.0.0   | Shimmer effect for Flutter                                                                                                                                        |

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## 👨‍💻 Author

**Shokhrukhbek Yuldoshev**

-   Github: [@ShokhrukhbekYuldoshev](https://github.com/ShokhrukhbekYuldoshev)
-   Email: [@shokhrukhbekdev@gmail.com](mailto:shokhrukhbekdev@gmail.com)

## 🌟 Show your support

Give a ⭐️ if you like this project!
