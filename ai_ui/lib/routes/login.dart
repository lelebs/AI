import 'dart:convert';

import 'package:ai_ui/services/router.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import '../models/loginModel.dart';
import '../utils/error.utils.dart';

import '../constants.dart' as Constants;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: mainContainer(),
      ),
    );
  }

  bool _verificarLogin() {
    if (email.text == '' || senha.text == '') {
      showDialogError(
          context, true, "Preenchimento obrigatório: [Login] e [Senha]");
      return false;
    }

    return true;
  }

  Widget mainContainer() {
    return new SingleChildScrollView(
      child: Container(
          child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'A',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'I',
                          style: TextStyle(color: Colors.blue, fontSize: 30),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 80,
                ),
                textField('Email: ', email),
                textField('Senha: ', senha, senha: true),
                SizedBox(
                  height: 30,
                ),
                buttonEntrarWidget(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget textField(String title, TextEditingController controler,
      {bool senha = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: senha,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey[200],
                filled: true),
            controller: controler,
          )
        ],
      ),
    );
  }

  Widget buttonEntrarWidget() {
    return InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue, Colors.blue])),
          child: Text(
            'Entrar',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onTap: () async {
          if (_verificarLogin()) {
            var user = new LoginModel(email.text, senha.text);
            var body = json.encode(user);
            try {
              var response = await http.post(
                  Constants.AuthAPILink + 'generatetoken',
                  body: body,
                  headers: {"content-type": "application/json; charset=utf-8"});
              if (response.statusCode == 200) {
                var retorno = json.decode(response.body);
                var prefs = FlutterSecureStorage();
                await prefs.write(
                    key: Constants.LoginKey,
                    value: retorno['token'].toString());
                await prefs.write(
                    key: Constants.AuthKey,
                    value: json.encode(retorno['auth']));
                Toast.show("Login realizado com sucesso!", context);
                GetIt.instance<NavigationService>().navigateTo('home');
              } else {
                throw new Exception();
              }
            } catch (value) {
              showDialogError(context, true,
                  'Ocorreu um erro ao realizar login. Verifique seu usuário e senha');
            }
          }
        });
  }
}
