import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padaria/datas/product_data.dart';
import 'package:padaria/tiles/product_tile.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot categorySnapshot;

  CategoryTile(this.categorySnapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0.0, 4.0),
              blurRadius: 1.0
          )
          ],
          color: Theme
              .of(context)
              .backgroundColor,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(categorySnapshot.data["title"], style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),),
                  FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance.collection("products").document(categorySnapshot.documentID).collection("items").getDocuments(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Center( child: CircularProgressIndicator(),);
                        }
                        else {
                          return Column(
                            children: snapshot.data.documents.map((product){
                              ProductData data = ProductData.fromDocument(product);
                              data.category = this.categorySnapshot.documentID;
                              return Column(children: <Widget>[
                                Divider(),
                                ProductTile(data),
                              ],);
                            }).toList().reversed.toList(),
                          );
                        }
                      }
                  )
            ]
        )
    );
  }
}
