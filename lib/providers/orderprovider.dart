// import 'package:flutter/foundation.dart';

// import '../model/cartitem.dart';
// import '../model/listorder.dart'; 

// class OrderProvider with ChangeNotifier {
//   List<ListOrder> _orders = [];
//   List<ListOrder> get orders {
//     return [..._orders];
//   }

//   void addOrder(List<CartItem> cartProduct, double total) {
//     _orders.insert(
//         0,
//         ListOrder(
//             id: DateTime.now().toString(),
//             amount: total,
//             products: cartProduct,
//             dateTime: DateTime.now()));
//     notifyListeners();
//   }
// }
