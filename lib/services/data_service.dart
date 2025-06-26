import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> loadItems() async {
  try {
    final url = Uri.parse('http://192.168.158.241:8080/products');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      List<dynamic> data = jsonDecode(res.body);
      for (var item in data) {
        item['quantity'] = item['quantity'] ?? 0;
      }
      return data;
    } else {
      throw Exception('Failed to load products: ${res.statusCode}');
    }
  } catch (e) {
    print('❌ Error loading products: $e');
    throw Exception('Failed to load products');
  }
}
