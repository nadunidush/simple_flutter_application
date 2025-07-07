import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:simple_flutter_application/config/address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> cartItems = [];

  //Get All Cart Phones
  Future<void> fetchCart() async {
    final res = await http.get(Uri.parse('http://${ipAddress}:8080/cart'));
    if (res.statusCode == 200) {
      setState(() {
        cartItems = json.decode(res.body);
      });
    }
  }

  //Update the quentity of the phone
  Future<void> updateQuantity(int index, int change) async {
    final newQty = cartItems[index]["quantity"] + change;
    if (newQty < 1) return; // 👈 Prevent quantity below 1

    setState(() {
      cartItems[index]["quantity"] = newQty;
    });

    await http.put(
      Uri.parse('http://${ipAddress}:8080/cart/${cartItems[index]["_id"]}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"quantity": newQty}),
    );
  }

  //Delete the of phone from cart
  Future<void> deleteItem(int index) async {
    final id = cartItems[index]["_id"];
    await http.delete(Uri.parse('http://${ipAddress}:8080/cart/$id'));
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, cartItems),
        ),
        title: const Text(
          "🛒 Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(12),
                        child: ListTile(
                          title: Text(
                            item["name"],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rs. ${(item["price"] * item["quantity"]).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (cartItems[index]["quantity"] > 1) {
                                    updateQuantity(index, -1);
                                  }
                                },
                              ),
                              Text("${item["quantity"]}"),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => updateQuantity(index, 1),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => deleteItem(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                  label: const Text(
                    "Checkout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 146, 0, 191),
                    elevation: 12,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.tealAccent.withOpacity(0.4),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
