import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_application/services/item_provider.dart';
import 'package:simple_flutter_application/widgets/details_screen/details_screen_widgets.dart';

class DetailScreen extends StatelessWidget {
  final dynamic item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item["title"],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.tealAccent.withOpacity(0.3),
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
          Consumer<ItemProvider>(
            builder: (context, favoriteProvider, child) {
              bool isFav = favoriteProvider.isFavorite(item["id"]);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  favoriteProvider.toggleFavorite(item["id"]);
                },
              );
            },
          ),
        ],
      ),

      backgroundColor: Colors.black,
      body: Stack(children: [buildBackground(), _buildContent(context, item)]),
    );
  }

 

  Widget _buildContent(BuildContext context, dynamic item) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPhoneImage(),
            const SizedBox(height: 15),
            _buildGlassCard(item),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(item["image"], width: 250),
    );
  }

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

  Widget _buildPhoneDetails() {
    return Column(
      children: [
        buildInfoRow(Icons.phone_android, "Screen: ${item["screen"]}"),
        buildInfoRow(Icons.memory, "Processor: ${item["processor"]}"),
        buildInfoRow(
          Icons.battery_charging_full,
          "Battery: ${item["battery"]}",
        ),
        buildInfoRow(Icons.camera_alt, "Camera: ${item["camera"]}"),
        buildInfoRow(Icons.money, "Price: ${item["price"]}"),
      ],
    );
  }

   
}
