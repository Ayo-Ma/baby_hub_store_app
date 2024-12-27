import 'package:flutter/material.dart';
import 'package:baby_hub_store_app/Models/modelFash.dart'; // Update with your actual path

class CuratedItems extends StatelessWidget {
  final AppModel eCommerceItems;
  final Size size;

  const CuratedItems({
    Key? key,
    required this.eCommerceItems,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.6,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              eCommerceItems.image,
              height: size.height * 0.25,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              eCommerceItems.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              eCommerceItems.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "\$${eCommerceItems.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.pink,
                    height: 1.5,
                  ),
                ),
                SizedBox(width: 5),
                // if (eCommerceItems.isCheck)
                //   Text(
                //     "\$${(eCommerceItems.price + 255).toStringAsFixed(2)}",
                //     style: TextStyle(
                //       color: Colors.black26,
                //       decoration: TextDecoration.lineThrough,
                //       decorationColor: Colors.black26,
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
