import 'package:flutter/material.dart';
import 'package:padaria/datas/product_data.dart';
import 'package:padaria/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final ProductData productData;

  ProductTile(this.productData);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return ProductScreen(productData);
            })
          );
        },
        child: Container(
          height: 100.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(productData.title, style: TextStyle(color: Colors.black54, fontSize: 16.0, fontWeight: FontWeight.w700),),
                    Container(padding: EdgeInsets.only(right: 8.0),child: Text(productData.description, style: TextStyle(color: Colors.black54, ),)),
                    Text("R\$ ${productData.price.toStringAsFixed(2)}", style: TextStyle(color: Colors.black54,fontSize: 16.0, fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(image: NetworkImage(productData.images[0]), fit: BoxFit.cover),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
