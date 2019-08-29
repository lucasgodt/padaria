import 'package:flutter/material.dart';
import 'package:padaria/models/cart_model.dart';
import 'package:padaria/models/user_model.dart';
import 'package:padaria/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: "Sua Padaria",
              theme: ThemeData(
                  primaryColor: Colors.yellow,
                  buttonColor: Colors.blue[900],
                  backgroundColor: Colors.white
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
