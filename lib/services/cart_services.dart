List<Map<String, dynamic>> cart = [];

void addToCart(dynamic item) {
  final existing = cart.indexWhere((i) => i['id'] == item['id']);
  if (existing >= 0) {
    cart[existing]['quantity'] = item['quantity'];
  } else {
    cart.add({...item}); 
  }
}

List<Map<String, dynamic>> getCartItems() => cart;
