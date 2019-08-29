import 'package:flutter/material.dart';
import 'package:padaria/tiles/bakery_tile.dart';

class BakeryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fornadas"),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            BakeryTile()
          ],
        ),
      ),
    );
  }
}
