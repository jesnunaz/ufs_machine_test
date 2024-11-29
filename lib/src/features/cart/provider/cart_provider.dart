import 'package:flutter/material.dart';
import 'package:flutter_ufs_machine_test/src/features/product/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  bool isloading = false;

  List<ProductModel> products = [];

  addtocart(ProductModel product) {
    products.add(product);
    notifyListeners();
  }

  deletefromcart(ProductModel product) {
    products.remove(product);
    notifyListeners();
  }
}
