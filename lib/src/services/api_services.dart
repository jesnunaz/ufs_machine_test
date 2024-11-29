import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  getcategories() async {
    final url = Uri.parse('$baseUrl/categories.php');
    var response = await http.get(url);
    try {
      var data = jsonDecode(response.body);
      return data;
    } catch (e) {}
  }

  getproducts(String name) async {
    final url = Uri.parse('$baseUrl/filter.php?c=$name');
    var response = await http.get(url);
    try {
      var data = jsonDecode(response.body);
      return data;
    } catch (e) {}
  }
}
