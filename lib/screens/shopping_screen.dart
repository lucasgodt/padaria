import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padaria/models/user_model.dart';
import 'package:padaria/screens/login_screen.dart';
import 'package:padaria/tiles/category_tile.dart';
import 'package:padaria/widgets/nav_bar.dart';
import 'package:scoped_model/scoped_model.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {

  bool mainAppBarEnded = false;
  Future<QuerySnapshot> qSnapshot;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    qSnapshot = Firestore.instance.collection("products").getDocuments();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        NavBar(qSnapshot, scrollController),
        FutureBuilder<QuerySnapshot>(
            future: qSnapshot,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SliverList(
                  //TODO indicador no lugar errado
                  delegate: SliverChildListDelegate([
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ]),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CategoryTile(snapshot.data.documents[index]);
                  }, childCount: snapshot.data.documents.length),
                );
              }
            }),
      ],
    );
  }
}
