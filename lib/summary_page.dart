import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
import 'cart_provider.dart';
import 'cart_item.dart';
import 'category_page.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    CartItem item = cartProvider.items[index];
                    return ListTile(
                      title: Text(item.category),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Row(
                      mainAxisSize: MainAxisSize.min, // This is needed to keep the row size to a minimum
                      children: [
                        Text('\$${item.price}'),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Call a method in your provider to remove the item
                            cartProvider.removeItem(item.id); // Assuming removeItem is a method in your provider
                          },
                        ),
                      ],
                    ),
                      // Add more UI elements or functionality as needed
                    );
                  },
                )
              ),
              SizedBox(
                width: double.infinity, // Makes the button expand horizontally
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoryPage(), // Replace with your destination page
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor : Colors.blue, // Background color
                    padding: const EdgeInsets.symmetric(vertical: 15), // Vertical padding for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: const Text('Add more items', style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
              SizedBox(
                width: double.infinity, // Makes the button expand horizontally
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoryPage(), // Replace with your destination page
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor : Colors.green[400], // Background color
                    padding: const EdgeInsets.symmetric(vertical: 15), // Vertical padding for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: const Text('SUMMIT', style: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
          ],); 
        },
      ),
    );
  }
}
