// import 'package:flutter/foundation.dart';

// import '../model/cartitem.dart';
 
// class CartProvider with ChangeNotifier {
//   Map<String, CartItem> _item = {};
//   Map<String, CartItem> get items {
//     return {..._item};
//   }

//   int get itemCount {
//     return _item.length;
//   }

//   double get totalPrice {
//     var total = 0.0;
//     _item.forEach((key, cartItem) {
//       total += cartItem.price! * cartItem.quantity!;
//     });
//     return total;
//   }

//   void addItem(String productId, double price, String title) {
//     if (_item.containsKey(productId)) {
//       _item.update(
//           productId,
//           (value) => CartItem(
//               id: value.id,
//               title: value.title,
//               quantity: value.quantity! + 1,
//               price: value.price));
//     } else {
//       _item.putIfAbsent(
//           productId,
//           () => CartItem(
//               id: DateTime.now().toString(),
//               title: title,
//               quantity: 1,
//               price: price));
//     }
//     notifyListeners();
//   }

//   void removeItem(String? productId) {
//     _item.remove(productId);
//     notifyListeners();
//   }

//   void clear() {
//     _item = {};
//     notifyListeners();
//   }
// }
