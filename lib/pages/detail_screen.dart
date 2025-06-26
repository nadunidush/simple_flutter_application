import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_flutter_application/constants/colors.dart';
import 'package:simple_flutter_application/services/cart_services.dart';
import 'package:simple_flutter_application/services/data_service.dart';

import 'package:simple_flutter_application/services/item_provider.dart';
import 'package:simple_flutter_application/widgets/details_screen/details_screen_widgets.dart';

class DetailScreen extends StatefulWidget {
  final dynamic item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //Load Items from data_services.dart service.
  List<dynamic> items = [];
  @override
  void initState() {
    super.initState();
    loadItems().then((loadedItems) {
      setState(() {
        items = loadedItems.map((item) {
          item["quantity"] = 1;
          return item;
        }).toList();
      });
    });
  }

  //add to cart function
  void addToCartItems() async {
    final item = widget.item;
    
    final cartItem = {
      "productId": item["_id"],
      "name": item["title"],
      "price": item["price"],
      "quantity": item["quantity"] ?? 1,
    };

    final response = await http.post(
      Uri.parse('http://192.168.158.241:8080/cart'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cartItem),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("✅ Added to Cart!")));
      Navigator.pushNamed(context, '/cart');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("❌ Failed to add to cart.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item["title"],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: kShadowColor.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(2)),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          //Function of heart 
          Consumer<ItemProvider>(
            builder: (context, favoriteProvider, child) {
              bool isFav = favoriteProvider.isFavorite(widget.item["id"]);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  favoriteProvider.toggleFavorite(widget.item["id"]);
                },
              );
            },
          ),
        ],
      ),

      backgroundColor: Colors.black,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _buildContent(context, widget.item),
              Positioned(
                top: 10,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 4,
                      color: const Color.fromARGB(255, 41, 64, 78),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      addToCart(widget.item);
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //content widget
  Widget _buildContent(BuildContext context, dynamic item) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 45),
            //Image of Phone
            _buildPhoneImage(),
            const SizedBox(height: 15),

            //Details of phone
            _buildGlassCard(item),
            SizedBox(height: 15),

            //Add to Cart Button
            ElevatedButton.icon(
              onPressed: () async {
                addToCartItems();
              },
              icon: const Icon(
                Icons.shopping_cart_checkout_rounded,
                color: Colors.white,
              ),
              label: const Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 102, 191, 0),
                elevation: 12,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Image of Phone widget
  Widget _buildPhoneImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(widget.item["image"], width: 250),
    );
  }

  //Card of Phone widget
  Widget _buildGlassCard(dynamic item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item["title"],
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            _buildPhoneDetails(),
            const SizedBox(height: 15),
            Text(
              item["description"],
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  //Details of phone
  Widget _buildPhoneDetails() {
    return Column(
      children: [
        buildInfoRow(Icons.phone_android, "Screen: ${widget.item["screen"]}"),
        buildInfoRow(Icons.memory, "Processor: ${widget.item["processor"]}"),
        buildInfoRow(
          Icons.battery_charging_full,
          "Battery: ${widget.item["battery"]}",
        ),
        buildInfoRow(Icons.camera_alt, "Camera: ${widget.item["camera"]}"),
        buildInfoRow(Icons.money, "Price: ${widget.item["price"]}"),
      ],
    );
  }
}
