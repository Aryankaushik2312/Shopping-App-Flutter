import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  int get totalItem{
    var total = 0;
    _items.forEach((key, cartItem){
      total += cartItem.quantity;
    });
    return total;
  }

//Getting Order Amount
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    //If Item of that ProductId is Already Available
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    }
    //If Item of that ProductId is not Available
    else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  //Remove The Product from Cart Screen
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

//When UNDO Press in SnackBar
  void removeSingleItem(String productId) {
    //When 0 Item Of that ProductID
    if (!_items.containsKey(productId)) {
      return;
    }
    //When More Than 1 Item Of that ProductID
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    }
    //When exactly 1 Item Of that ProductID
    else {
      _items.remove(productId);
    }
    notifyListeners();
  }

//When we Press on Order Now
  void clear() {
    _items = {};
    notifyListeners();
  }
}
