import 'package:flutter/material.dart';
import 'price_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const showGrid = false; // Set to false to show ListView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page'),
      ),
      body: Center(child: _buildGrid(context)), // showGrid ? _buildGrid() : _buildList()),
    );
  }

  Widget _buildGrid(context) => GridView.extent(
      maxCrossAxisExtent: 200,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(context, [
        {'image': 'coat.png', 'keyword': 'coat'},
        {'image': 'trouser.png', 'keyword': 'trouser'},
        {'image': 'tshirt.png', 'keyword': 'tshirt'},
        {'image': 'boots.png', 'keyword': 'boots'},
        {'image': 'cap.png', 'keyword': 'cap'},
        {'image': 'skirt.png', 'keyword': 'skirt'},
        {'image': 'jewelry.png', 'keyword': 'jewelry'},
      ]),
    );

List<Widget> _buildGridTileList(context, List<Map<String, String>> imageInfo) => 
    imageInfo.map((info) => GestureDetector(
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PricePage(keyword: info['keyword']!),
            ),
          );
      },
      child: Container(
        child: Image.asset('assets/images/${info['image']}')
      )
    )).toList();
}