import 'package:flutter/material.dart';
import 'package:baby_hub_store_app/Models/category_model.dart';
import 'package:baby_hub_store_app/Models/modelFash.dart';
import 'package:baby_hub_store_app/Utils/colors.dart';
import 'package:baby_hub_store_app/Views/category_items.dart';
import 'package:baby_hub_store_app/Views/product_detail_screen.dart';
import 'package:baby_hub_store_app/Widgets/banner.dart';
import 'package:baby_hub_store_app/Widgets/curated_items.dart';
import 'package:baby_hub_store_app/Widgets/featured_section.dart'; // Import the FeaturedSection widget
import 'package:iconsax/iconsax.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            // for header parts
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "category_image/logo.png", // Use the correct path to your image asset
                    height: 40,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Iconsax.shopping_bag,
                        size: 28,
                      ),
                      Positioned(
                        right: -3,
                        top: -5,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            HeroBanner(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shop By Category",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "View More",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
            ),
            //category
            FutureBuilder<List<CategoryModel>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final categories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        categories.length,
                        (index) => InkWell(
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
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: fbackgeoundColor1,
                                  backgroundImage: NetworkImage(
                                    categories[index].imageUrl,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                categories[index].name,
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Handpicked with Love for Your Little One",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "View More",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0,
                      color: Colors.black45,
                    ),
                  )
                ],
              ),
            ),
            // Featured Section
            FutureBuilder<List<AppModel>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final products = snapshot.data!;
                  final featuredItems =
                      products.where((item) => item.isFeatured).toList();
                  return FeaturedSection(featuredItems: featuredItems);
                }
              },
            ),
            //handpicked section
            FutureBuilder<List<AppModel>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final products = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(products.length, (index) {
                        final eCommerceItems = products[index];
                        return Padding(
                          padding: index == 0
                              ? EdgeInsets.symmetric(horizontal: 20)
                              : EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(
                                    eCommerceApp: eCommerceItems,
                                  ),
                                ),
                              );
                            },
                            child: CuratedItems(
                              eCommerceItems: eCommerceItems,
                              size: size,
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
