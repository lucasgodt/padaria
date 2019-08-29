import 'package:flutter/material.dart';

class PromotionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text("Promoções"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Programa de fidelidade", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 20.0),)),
            Text("A cada 5 pedidos ganhe 20% de desconto na próxima compra", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 16.0),),
            SizedBox(height: 8.0),
            LinearProgressIndicator(
              //Fzer lógica do progresso
              value: 0.2,
            ),
            SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Text("1 compra realizada", style: TextStyle(color: Theme.of(context).textSelectionColor),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
