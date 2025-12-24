import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/MyCard.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final uid = FirebaseAuth.instance.currentUser!.uid;

  final productsRef =
      FirebaseFirestore.instance.collection("Products");

  final cartRef =
      FirebaseFirestore.instance.collection("addToCart");

  Future<void> addToCart(String prodId) async {
    await cartRef.add({
      "userId": uid,
      "prodId": prodId,
    });
  }

  Future<void> removeFromCart(String prodId) async {
    final snap = await cartRef
        .where("userId", isEqualTo: uid)
        .where("prodId", isEqualTo: prodId)
        .get();

    for (var doc in snap.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Our Products!", style: TextStyle(fontSize: 18)),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: productsRef.snapshots(),
              builder: (context, productSnap) {
                if (!productSnap.hasData) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                final products = productSnap.data!.docs;

                return StreamBuilder<QuerySnapshot>(
                  stream: cartRef
                      .where("userId", isEqualTo: uid)
                      .snapshots(),
                  builder: (context, cartSnap) {
                    if (!cartSnap.hasData) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }

                    /// cart product ids
                    final cartIds = cartSnap.data!.docs
                        .map((e) => e["prodId"])
                        .toSet();

                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        final prod = products[index];
                        final isInCart =
                            cartIds.contains(prod.id);

                        return MyCard(
                          onPressed: () async {
                            if (isInCart) {
                              await removeFromCart(prod.id);
                            } else {
                              await addToCart(prod.id);
                            }
                          },
                          cartIcon: Icon(
                            isInCart
                                ? Icons.delete
                                : Icons.shopping_bag,
                            color: isInCart
                                ? Colors.red
                                : Colors.blueAccent,
                            size: 18,
                          ),
                          imageName: prod['prodImage'],
                          productName: prod['prodName'],
                          productDescription:
                              prod['prodDescription'],
                          productPrice: prod['prodPrice'],
                        );
                      },
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
