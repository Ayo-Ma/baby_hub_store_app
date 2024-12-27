import 'package:flutter/material.dart';
import 'package:baby_hub_store_app/Models/modelFash.dart'; // Update with your actual path
import 'package:baby_hub_store_app/Views/product_detail_screen.dart'; // Update with your actual path

class CategoryItems extends StatefulWidget {
  final String category;
  final List<AppModel> categoryItems;

  const CategoryItems({
    super.key,
    required this.category,
    required this.categoryItems,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  List<AppModel> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.categoryItems;
  }

  void filterSearchResults(String query) {
    List<AppModel> dummySearchList = [];
    dummySearchList.addAll(widget.categoryItems);
    if (query.isNotEmpty) {
      List<AppModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(widget.categoryItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black38,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'No products in this category or we are currently out of stock',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        leading: Image.asset(
                            item.image), // Use Image.asset for local images
                        title: Text(item.name),
                        subtitle: Text('\$${item.price}'),
                        onTap: () {
                          // Navigate to the product detail screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(
                                eCommerceApp: item,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
