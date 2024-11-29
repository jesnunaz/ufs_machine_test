import 'package:flutter/material.dart';
import 'package:flutter_ufs_machine_test/src/features/cart/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(builder: (context, provider, _) {
        return ListView.separated(
          itemCount: provider.products.length,
          separatorBuilder: (context, index) => const Divider(),
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) => SizedBox(
            height: 100,
            child: Row(
              children: [
                Image.network(provider.products[index].strMealThumb!),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    provider.products[index].strMeal!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                IconButton(
                    onPressed: () {
                      provider.deletefromcart(provider.products[index]);
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
        );
      }),
    );
  }
}
