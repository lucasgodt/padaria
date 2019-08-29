import 'package:flutter/material.dart';
import 'package:padaria/models/user_model.dart';
import 'package:padaria/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return SignupScreen();
                }));
              },
            )
          ],
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
                      controller: _passController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida";
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if(_emailController.text.isEmpty)
                              _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text("Insira seu e-mail para recuperação"),
                                    backgroundColor: Colors.redAccent,
                                    duration: Duration(seconds: 4),)
                              );
                            else {
                              model.recoverPass(_emailController.text);
                              _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: Text("Confira seu email"),
                                    backgroundColor: Theme
                                        .of(context)
                                        .primaryColor,
                                    duration: Duration(seconds: 2),)
                              );
                            }
                          },
                          child: Text(
                            "Esqueci a senha",
                            textAlign: TextAlign.right,
                          )),
                    ),
                    SizedBox(height: 16.0),
                    RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            model.signIn(email: _emailController.text , pass: _passController.text, onSuccess: _onSuccess, onFailed: _onFailed );
                          }
                        },
                        child: Text(
                          "Entrar",
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
      Navigator.of(context).pop();
  }

  void _onFailed(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao logar"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),)
    );
  }
}

