import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'summary_page.dart';

class PricePage extends StatefulWidget {
  final String keyword;

  const PricePage({super.key, required this.keyword});

  @override
  // ignore: library_private_types_in_public_api
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Price Page'),
        ),
        body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Input Field',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(child: _buildGrid(context)),
            const Center(
              child: Text("SELECT DISCOUNT"),
            ),
            Expanded(child: _buildDiscountGrid(context)),
            const Center(
              child: Text("SELECT UNITS"),
            ),
            Expanded(child: _buildUnitGrid(context, cart)),
          ]);
        }));
  }

  Widget _buildGrid(context) => GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(context, [
          {'text': '1'},
          {'text': '2'},
          {'text': '3'},
          {'text': '4'},
          {'text': '5'},
          {'text': '6'},
          {'text': '7'},
          {'text': '8'},
          {'text': '9'},
          {'text': '0'},
          {'text': '.'},
          {'text': 'Clear'},
        ]),
      );

  List<Widget> _buildGridTileList(
          context, List<Map<String, String>> imageInfo) =>
      imageInfo
          .map((info) => GestureDetector(
              onTap: () {
                if (info['text'] == "Clear") {
                  _priceController.text = "";
                } else {
                  _priceController.text = _priceController.text + info['text']!;
                }
              },
              child: Container(
                  color: Colors.indigoAccent,
                  child: Center(
                      child: Text(info[
                          'text']!)) // Image.asset('assets/images/${info['image']}')
                  )))
          .toList();

  Widget _buildDiscountGrid(context) => GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridDiscountTileList(context, [
          {'text': '20%'},
          {'text': '30%'},
          {'text': '40%'},
          {'text': '50%'},
        ]),
      );

  List<Widget> _buildGridDiscountTileList(
          context, List<Map<String, String>> imageInfo) =>
      imageInfo
          .map((info) => GestureDetector(
              onTap: () {
                double currentValue =
                    double.tryParse(_priceController.text) ?? 0;
                double result = 0;

                if (info['text'] == "20%") {
                  result = currentValue - currentValue * 0.20;
                } else if (info['text'] == "30%") {
                  result = currentValue - currentValue * 0.30;
                } else if (info['text'] == "40%") {
                  result = currentValue - currentValue * 0.40;
                } else if (info['text'] == "50%") {
                  result = currentValue - currentValue * 0.50;
                }

                _priceController.text = result.toStringAsFixed(2);
              },
              child: Container(
                  color: Colors.indigoAccent,
                  child: Center(child: Text(info['text']!)))))
          .toList();

  Widget _buildUnitGrid(context, cart) => GridView.extent(
        maxCrossAxisExtent: 100,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridUnitTileList(
          context, 
          cart, [
          {'text': '1'},
          {'text': '2'},
          {'text': '3'},
          {'text': '4'},
        ]),
      );

  List<Widget> _buildGridUnitTileList(
          context, cart, List<Map<String, String>> imageInfo) =>
      imageInfo
          .map((info) => GestureDetector(
              onTap: () {
                String units = info['text']!;

                double currentPrice = double.tryParse(_priceController.text) ?? 0;
                int quantity = int.tryParse(units) ?? 0;
                
                cart.addItem(currentPrice, quantity, widget.keyword);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SummaryPage(),
                  ),
                );
              },
              child: Container(
                  color: Colors.indigoAccent,
                  child: Center(child: Text(info['text']!)))))
          .toList();
}
