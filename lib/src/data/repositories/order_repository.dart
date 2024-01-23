import 'package:food_ninja/src/data/models/order.dart' as model;
import 'package:food_ninja/src/data/models/order_status.dart';
import 'package:food_ninja/src/data/models/payment_method.dart';
import 'package:food_ninja/src/data/services/firestore_db.dart';
import 'package:hive/hive.dart';

import '../models/food.dart';

class OrderRepository {
  final FirestoreDatabase _db = FirestoreDatabase();
  static final List<Food> cart = [];

  static final Box<dynamic> box = Hive.box('myBox');

  // load cart from hive
  static void loadCart() {
    if (box.containsKey('cart')) {
      final List<Food> cartList = List<Food>.from(box.get('cart'));
      cart.clear();
      for (Food item in cartList) {
        cart.add(item);
      }
    }
  }

  // update cart in hive
  void updateHive() {
    box.put('cart', cart);
  }

  void addToCart(Food food) {
    if (cart.contains(food)) {
      cart[cart.indexOf(food)].quantity++;
    } else {
      cart.add(food);
      food.quantity++;
    }
    updateHive();
  }

  void removeFromCart(Food food) {
    if (cart.contains(food)) {
      if (food.quantity > 1) {
        food.quantity--;
      }
    }
    updateHive();
  }

  void removeCompletelyFromCart(Food food) {
    if (cart.contains(food)) {
      cart.remove(food);
      food.quantity = 0;
    }
    updateHive();
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

  Future<model.Order> createOrder() async {
    final model.Order order = model.Order(
      cart: [...cart],
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      discount: discount,
      total: total,
      createdAt: DateTime.now(),
      status: OrderStatus.delivered,
      userEmail: box.get('email'),
      restaurant: cart[0].restaurant,
      paymentMethod: box.get('paymentMethod', defaultValue: 'visa') == 'visa'
          ? PaymentMethod.visa
          : PaymentMethod.paypal,
    );

    // firestore
    await _db.addDocument(
      'orders',
      order.toMap(),
    );

    cart.clear();
    updateHive();

    return order;
  }

  Future<List<model.Order>> fetchOrders() async {
    final List<model.Order> orders = [];
    var data = await _db.getDocumentsWithQuery(
      'orders',
      'userEmail',
      box.get('email'),
    );
    for (var item in data.docs) {
      model.Order order = model.Order.fromMap(
        item.data() as Map<String, dynamic>,
      );
      order.id = item.id;
      orders.add(order);
    }

    // sort by date
    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return orders;
  }
}
