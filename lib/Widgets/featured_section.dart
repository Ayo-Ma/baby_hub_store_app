import 'package:flutter/material.dart';
import 'package:baby_hub_store_app/Models/modelFash.dart'; // Update with your actual path
import 'package:baby_hub_store_app/Widgets/curated_items.dart'; // Update with your actual path

class FeaturedSection extends StatelessWidget {
  final List<AppModel> featuredItems;

  const FeaturedSection({
    Key? key,
    required this.featuredItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Featured Products",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              featuredItems.length,
              (index) => CuratedItems(
                eCommerceItems: featuredItems[index],
                size: size,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
