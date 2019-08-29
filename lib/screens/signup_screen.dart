import 'package:flutter/material.dart';
import 'package:padaria/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();
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
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (text) {
                        if (text.isEmpty) return "Nome inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "E-mail"),
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
                      controller: _pass1Controller,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6){
                          return "Senha inválida";
                        } else if(_pass1Controller.text != _pass2Controller.text) {
                          return "Senhas diferentes";
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _pass2Controller,
                      decoration: InputDecoration(hintText: "Senha novamente"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6){
                          return "Senha inválida";
                        } else if(_pass1Controller.text != _pass2Controller.text) {
                          return "Senhas diferentes";
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(hintText: "Endereço"),
                      validator: (text) {
                        if (text.isEmpty) return "Endereço inválido";
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: "Telefone"),
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

                            model.signUp(
                                userData: userData,
                                pass: _pass1Controller.text,
                                onSuccess: _onSuccess,
                                onFailed: _onFailed
                            );
                          }
                        },
                        child: Text(
                          "Criar conta",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor)
                  ],
                ));
          },
        ));
  }

  void _onSuccess(){
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Usuário criado com sucesso"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),)
      );
      Future.delayed(Duration(seconds: 2)).then((_){
        Navigator.of(context).pop();
      });
  }

  void _onFailed(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );
  }
}

