import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/MyCard.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final Stream<QuerySnapshot> prods = FirebaseFirestore.instance
      .collection("Products")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Our Products!"),
          Flexible(
            child: StreamBuilder(
              stream: prods,
              builder: (context, snapshot) {
                return GridView.builder(
                  itemCount: snapshot.data!.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    // crossAxisSpacing: 30,
                    // mainAxisSpacing: 30,
                  ),
                  itemBuilder: (context, index) {
                    final prodData = snapshot.data!.docs;
                    return MyCard(
                      imageName: prodData[index]['prodImage'],
                      productName: prodData[index]['prodName'],
                      productDescription: prodData[index]['prodDescription'],
                      productPrice: prodData[index]['prodPrice'],
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
