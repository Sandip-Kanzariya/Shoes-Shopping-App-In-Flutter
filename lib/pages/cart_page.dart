import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text(
                        'Are you sure you want to remove the product from your cart?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<CartProvider>()
                                .removeProduct(cartItem);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem['title'].toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Price: ${cartItem['price']}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            subtitle: Text('Size: ${cartItem['size']}'),
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Your order has been placed.'),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          // Clear the cart
          cart.clear();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black, // Background color
          textStyle: TextStyle(
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text('Check Out'),
      ),
    );
  }
}
