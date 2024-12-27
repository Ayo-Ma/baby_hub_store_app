import 'package:flutter/material.dart';
import 'package:baby_hub_store_app/Models/category_model.dart'; // Update with your actual path
import 'package:baby_hub_store_app/Models/modelFash.dart'; // Update with your actual path
import 'package:baby_hub_store_app/Views/category_items.dart'; // Update with your actual path
import 'package:iconsax/iconsax.dart'; // Import Iconsax or any other icon package

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
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
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryItems(
                          category: categories[index].name,
                          categoryItems: filterItems,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors
                              .blueAccent, // Customize the background color
                          child: Icon(
                            Iconsax
                                .category, // Use appropriate icon for each category
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
