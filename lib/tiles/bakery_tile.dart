import 'package:flutter/material.dart';

class BakeryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
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
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Próxima fornada", style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),),
                    Text("Pão de queijo", style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),),
                    Text("Horas: 16:00", style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),),
                  ]
              ),
            ),
            Expanded(
              flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/padaria-app-3aa62.appspot.com/o/pao-de-queijo.jpg?alt=media&token=35417eaa-7c76-40f1-b401-ba559c80a48f"), fit: BoxFit.cover),
                  ),
                )
            )
          ],
        )
    );
  }
}
