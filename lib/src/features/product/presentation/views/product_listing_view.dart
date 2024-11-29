import 'package:flutter/material.dart';
import 'package:flutter_ufs_machine_test/main.dart';
import 'package:flutter_ufs_machine_test/src/features/cart/presentation/view/cart_view.dart';
import 'package:flutter_ufs_machine_test/src/features/cart/provider/cart_provider.dart';
import 'package:flutter_ufs_machine_test/src/features/product/model/category_model.dart';
import 'package:flutter_ufs_machine_test/src/features/product/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListingView extends StatefulWidget {
  const ProductListingView({super.key});

  @override
  State<ProductListingView> createState() => _ProductListingViewState();
}

class _ProductListingViewState extends State<ProductListingView> {
  CategoryModel? selectedCategoryModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().getcategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Items',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartView()));
        },
        child: Text('Cart'),
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, _) {
        return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                DropdownButtonFormField<CategoryModel>(
                  value: selectedCategoryModel,
                  items: List.generate(
                      provider.categories.length,
                      (int i) => DropdownMenuItem<CategoryModel>(
                            value: provider.categories[i],
                            child: Text(provider.categories[i].strCategory.toString()),
                          )),
                  onChanged: (value) {
                    provider.getproducts(value!.strCategory!);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Select A Category',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: provider.isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            itemCount: provider.products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 300, crossAxisSpacing: 10),
                            itemBuilder: (context, index) => Column(
                              children: [
                                Expanded(
                                  child: Image.network(provider.products[index].strMealThumb!),
                                ),
                                Text(
                                  provider.products[index].strMeal!,
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<CartProvider>().addtocart(provider.products[index]);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added To Cart')));
                                  },
                                  child: Text('Add To Cart'),
                                  style: TextButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                                )
                              ],
                            ),
                          ))
              ],
            ));
      }),
    );
  }
}
