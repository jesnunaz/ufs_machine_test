import 'package:flutter/material.dart';
import 'package:flutter_ufs_machine_test/src/features/product/model/category_model.dart';
import 'package:flutter_ufs_machine_test/src/features/product/model/product_model.dart';
import 'package:flutter_ufs_machine_test/src/services/api_services.dart';

class ProductProvider extends ChangeNotifier {
  bool isloading = false;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  getcategories() async {
    isloading = true;
    notifyListeners();
    var data = await ApiServices().getcategories();
    try {
      List list = data['categories'];
      categories = List.generate(list.length, (int i) => CategoryModel.fromJson(list[i]));
    } catch (e) {}
    isloading = false;
    notifyListeners();
  }

  getproducts(String name) async {
    isloading = true;
    notifyListeners();
    var data = await ApiServices().getproducts(name);
    print(data);
    try {
      List list = data['meals'];
      products = List.generate(list.length, (int i) => ProductModel.fromJson(list[i]));
    } catch (e) {}
    isloading = false;
    notifyListeners();
  }
}
