import 'package:flutter/material.dart';

import 'package:baby_hub_store_app/Models/modelFash.dart'; // Update with your actual path

class ProductDetailScreen extends StatelessWidget {
  final AppModel eCommerceApp;

  const ProductDetailScreen({Key? key, required this.eCommerceApp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eCommerceApp.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                  eCommerceApp.image), // Use Image.asset for local images
              const SizedBox(height: 20),
              Text(
                eCommerceApp.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$${eCommerceApp.price}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Description: ${eCommerceApp.description}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Uploaded By: ${eCommerceApp.uploadedBy}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Quantity: ${eCommerceApp.quantity}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Category: ${eCommerceApp.category}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Colors: ${eCommerceApp.fcolor.map((color) => color.toString()).join(', ')}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Sizes: ${eCommerceApp.size.join(', ')}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Reviews:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...eCommerceApp.reviews.map((review) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '${review.comment} - Rating: ${review.rating}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
