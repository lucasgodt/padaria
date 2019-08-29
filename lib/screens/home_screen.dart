import 'package:flutter/material.dart';
import 'package:padaria/screens/cart_screen.dart';
import 'package:padaria/screens/shopping_screen.dart';
import 'package:padaria/tabs/bakery_tab.dart';
import 'package:padaria/tabs/orders_tab.dart';
import 'package:padaria/tabs/profile_tab.dart';
import 'package:padaria/tabs/promotions_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(
                p,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease
            );
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.store,
                  color: Colors.black54,), title: Text("Produtos",
              style: TextStyle(fontSize: 10, color: Colors.black54),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer,
                  color: Colors.black54,), title: Text("Fornadas",
              style: TextStyle(fontSize: 10, color: Colors.black54),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment,
                  color: Colors.black54,), title: Text("Pedidos",
              style: TextStyle(fontSize: 10, color: Colors.black54),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border,
                  color: Colors.black54,), title: Text("Promoções",
              style: TextStyle(fontSize: 10, color: Colors.black54),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,
                  color: Colors.black54,), title: Text("Carrinho",
              style: TextStyle(fontSize: 10, color: Colors.black54),)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,
                  color: Colors.black54,), title: Text("Perfil",
              style: TextStyle(fontSize: 10, color: Colors.black54),))
          ],
        ),
        body: PageView(
            onPageChanged: (p){
              setState(() {
                _page = p;
              });
            },
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ShoppingScreen(),
              BakeryTab(),
              OrdersTab(),
              PromotionsTab(),
              CartScreen(),
              ProfileTab(),
            ]));
  }

}