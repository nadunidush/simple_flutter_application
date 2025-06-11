import 'package:flutter/material.dart';

Widget buildBackground() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.blueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );
}

Widget buildInfoRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.tealAccent, size: 22),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ],
    ),
  );
}
