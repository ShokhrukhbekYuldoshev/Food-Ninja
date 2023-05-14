import 'package:food_ninja/models/order.dart' as model;
import 'package:food_ninja/services/firestore_db.dart';

import '../models/food.dart';

class OrderRepository {
  final FirestoreDatabase _db = FirestoreDatabase();
  static final List<Food> cart = [];

  Future<void> addOrder(model.Order order) async {
    await _db.addDocument(
      'orders',
      order.toMap(),
    );
  }

  void addToCart(Food food) {
    if (cart.contains(food)) {
      food.quantity++;
    } else {
      cart.add(food);
      food.quantity++;
    }
  }

  void removeFromCart(Food food) {
    if (cart.contains(food)) {
      if (food.quantity > 1) {
        food.quantity--;
      }
    }
  }

  void removeCompletelyFromCart(Food food) {
    if (cart.contains(food)) {
      cart.remove(food);
      food.quantity = 0;
    }
  }

  // subtotal
  static double get subtotal {
    double total = 0;
    for (var food in cart) {
      total += food.price * food.quantity;
    }
    return total;
  }

  // delivery fee
  static double get deliveryFee {
    return 10;
  }

  // discount
  static double get discount {
    return 0;
  }

  // total
  static double get total {
    return subtotal + deliveryFee - discount;
  }
}
