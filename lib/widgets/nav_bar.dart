import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padaria/models/user_model.dart';
import 'package:padaria/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class NavBar extends StatefulWidget {
  final Future<QuerySnapshot> qSnapshot;
  final ScrollController scrollController;

  NavBar(this.qSnapshot, this.scrollController);

  @override
  _NavBarState createState() => _NavBarState(qSnapshot, scrollController);
}

class _NavBarState extends State<NavBar> {
  Future<QuerySnapshot> qSnapshot;
  ScrollController scrollController;
  bool _mainAppBarEnded = false;
  List<int> _sizes;

  _NavBarState(this.qSnapshot, this.scrollController);

  _scrollListener() {
    int limit = 100;
    if (scrollController.offset >= limit) {
      setState(() {
        _mainAppBarEnded = true;
      });
    }
    if (scrollController.offset <= limit) {
      setState(() {
        _mainAppBarEnded = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 2.0,
      backgroundColor: Colors.white,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Image.asset(
          'lib/assets/images/logo.jpg',
          fit: BoxFit.fitHeight,
          alignment: Alignment.bottomCenter,
        ),
      ),
      actions: _mainAppBarEnded
          ? <Widget>[
              Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                      future: qSnapshot,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          _sizes = List(snapshot.data.documents.length);
                          return Container(
                            //TODO fazer lógica de seleção, se um botão estiver selecionado, ele deve ter uma cor e o fundo da appbar a imagem da categoria
                            child: ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  _sizes[index] = snapshot
                                      .data.documents[index].data["itemCount"];
                                  return MaterialButton(
                                      child: Text(snapshot
                                          .data.documents[index].data["title"]),
                                      onPressed: () {
                                        _moveTo(
                                            _calculatePos(index).toDouble());
                                      });
                                }),
                          );
                        }
                      }))
            ]
          : <Widget>[
              Material(
                color: Colors.transparent,
                child: InkResponse(
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    color: Colors.black54,
                    onPressed: () {
                      //TODO lógica
                    },
                  ),
                  radius: 20.0,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkResponse(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black54,
                    onPressed: () {
                      //TODO lógica
                    },
                  ),
                  radius: 20.0,
                ),
              ),
              ScopedModelDescendant<UserModel>(
                builder: (context, child, model) {
                  return PopupMenuButton(itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: MaterialButton(
                          child: SizedBox.expand(
                            child: Text(
                              "Informações",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            print("Informações");
                          },
                        ),
                      ),
                      PopupMenuItem(
                          child: model.isLoggedIn()
                              ? MaterialButton(
                                  child: SizedBox.expand(
                                      child: Text(
                                    "Sair",
                                    textAlign: TextAlign.center,
                                  )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    UserModel.of(context).signOut();
                                  },
                                )
                              : MaterialButton(
                                  child: SizedBox.expand(
                                      child: Text(
                                    "Entrar",
                                    textAlign: TextAlign.center,
                                  )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                  },
                                )),
                    ];
                  });
                },
              ),
            ],
    );
  }

  _moveTo(double position) {
    scrollController.animateTo(position,
        curve: Curves.ease, duration: Duration(milliseconds: 500));
  }

  int _calculatePos(int index) {
    int pos = 0;
    if (index == 0) {
      return 0;
    } else {
      while (index > 0) {
        pos += _sizes[index] * 100 + 100;
        index--;
      }
      return pos + 200;
    }
  }
}
