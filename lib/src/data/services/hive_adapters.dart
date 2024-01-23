import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ninja/src/data/models/food.dart';
import 'package:food_ninja/src/data/models/restaurant.dart';
import 'package:hive_flutter/adapters.dart';

class FirestoreDocumentReferenceAdapter extends TypeAdapter<DocumentReference> {
  @override
  final int typeId = 0;

  @override
  DocumentReference read(BinaryReader reader) {
    return FirebaseFirestore.instance.doc(reader.read());
  }

  @override
  void write(BinaryWriter writer, DocumentReference obj) {
    writer.write(obj.path);
  }
}

class FoodAdapter extends TypeAdapter<Food> {
  @override
  final int typeId = 1;

  @override
  Food read(BinaryReader reader) {
    return Food(
      name: reader.read(),
      description: reader.read(),
      price: reader.read(),
      image: reader.read(),
      category: reader.read(),
      restaurant: reader.read(),
      createdAt: reader.read(),
      ingredients: reader.read(),
      quantity: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Food obj) {
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.price);
    writer.write(obj.image);
    writer.write(obj.category);
    writer.write(obj.restaurant);
    writer.write(obj.createdAt);
    writer.write(obj.ingredients);
    writer.write(obj.quantity);
  }
}

class RestaurantAdapter extends TypeAdapter<Restaurant> {
  @override
  final int typeId = 3;

  @override
  Restaurant read(BinaryReader reader) {
    return Restaurant(
      name: reader.read(),
      location: reader.read(),
      createdAt: reader.read(),
      image: reader.read(),
      description: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Restaurant obj) {
    writer.write(obj.name);
    writer.write(obj.location);
    writer.write(obj.createdAt);
    writer.write(obj.image);
    writer.write(obj.description);
  }
}
