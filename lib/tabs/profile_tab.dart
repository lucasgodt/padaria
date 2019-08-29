import 'package:flutter/material.dart';
import 'package:padaria/models/user_model.dart';
import 'package:padaria/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("Meu perfil"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(!model.isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para editar seu perfil",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                      child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context){
                              return LoginScreen();
                            })
                        );
                      }
                  )
                ],
              ),
            );
          } else if(model.isLoading){
            return Center(child: CircularProgressIndicator(),);
          } else {

            _nameController.text = model.userData["name"];
            _emailController.text = model.userData["email"];
            _addressController.text = model.userData["address"];
            _phoneController.text = model.userData["phone"];

            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration( labelText: "Nome completo"),
                      validator: (text) {
                        if (text.isEmpty) return "Nome inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration( labelText: "E-mail" ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "E-mail inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration( labelText: "Endereço" ),
                      validator: (text) {
                        if (text.isEmpty) return "Endereço inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration( labelText: "Telefone" ),
                      validator: (text) {
                        if (text.isEmpty) return "Telefone inválido";
                      },
                    ),
                    SizedBox(height: 16.0),
                    RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {

                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _addressController.text,
                              "phone": _phoneController.text
                            };

                            model.updateUserData(
                                userData: userData,
                                onSuccess: _onSuccess,
                                onFailed: _onFailed
                            );
                          }
                        },
                        child: Text(
                          "Atualizar perfil",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor)
                  ],
                ));
          }
        },
      ),
    );
  }

  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Perfil atualizado com sucesso"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),)
    );
  }

  void _onFailed(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao atualizar perfil"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );
  }
}

