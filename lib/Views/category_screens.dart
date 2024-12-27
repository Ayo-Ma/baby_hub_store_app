import 'package:flutter/material.dart';
import 'package:baby_hub_store_app/Models/category_model.dart'; // Update with your actual path
import 'package:baby_hub_store_app/Models/modelFash.dart'; // Update with your actual path
import 'package:baby_hub_store_app/Views/category_items.dart'; // Update with your actual path

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<CategoryModel>> futureCategories;
  late Future<List<AppModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
    futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index].name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(categories[index].imageUrl),
                  ),
                  onTap: () async {
                    // Fetch products and filter based on the selected category
                    final products = await futureProducts;
                    final filterItems = products
                        .where((item) =>
                            item.category.toLowerCase() ==
                            categories[index].name.toLowerCase())
                        .toList();
                    // Navigate to the CategoryItems screen with the filtered items
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryItems(
                          category: categories[index].name,
                          categoryItems: filterItems,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
