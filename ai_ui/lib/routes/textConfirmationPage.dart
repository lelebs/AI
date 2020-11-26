import 'package:ai_ui/models/dropDownModel.dart';
import 'package:ai_ui/models/pesquisaCommand.dart';
import 'package:ai_ui/routes/pesquisaResultsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart' as Constants;

final opcoesDropDown = <DropDownModel>[DropDownModel(1,'Livro'), DropDownModel(2,'Filme')];

var textController = new TextEditingController();
var opcaoSelecionada = opcoesDropDown[0];

class TextConfirmationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    FlutterSecureStorage().read(key: Constants.LastRead).then((value) => textController.text = value);

    return TextConfirmationState();
  }
}

class TextConfirmationState extends State<TextConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirme o texto da pesquisa"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FlutterSecureStorage().delete(key: Constants.LastRead);
          var pesquisaCommand = new PesquisaCommand(textController.text, opcaoSelecionada.id);
          await Navigator.push(context, MaterialPageRoute(builder: (context) => PesquisaResultsPage(pesquisaCommand)));
        },
        child: Icon(Icons.check),
      ),      
      body: Column(
        children: <Widget>[
          Text("Texto reconhecido"),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8,
                controller: textController,
              ),
            )
          ),
          DropdownButton<DropDownModel>(
            value: opcaoSelecionada,
            items: opcoesDropDown.map((DropDownModel e) => new DropdownMenuItem(
              value: e,
              child: new Text(
                e.descricao
              )
            )).toList(), 
            onChanged: (value) => setState(() => opcaoSelecionada = value)
          ),
        ],
      )
    );
  }
  
}