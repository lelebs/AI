import 'dart:convert';

import 'package:ai_ui/models/pesquisaCommand.dart';
import 'package:ai_ui/models/pesquisaItemModel.dart';
import 'package:ai_ui/routes/searchDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as Constants;

List<PesquisaItem> resultadosPesquisa = new List<PesquisaItem>();

class PesquisaResultsPage extends StatefulWidget{
  final PesquisaCommand command;
  PesquisaResultsPage(this.command);
  
  @override
  State<StatefulWidget> createState() {
    return _PesquisaResultsState(this.command);
  }
}

class _PesquisaResultsState extends State<PesquisaResultsPage>{
  final PesquisaCommand pesquisaData;

  _PesquisaResultsState(this.pesquisaData);

  Future<dynamic> _getData() async {
    var body = pesquisaData.toJson();
    var request = await http.post(Constants.DataAPILink + "pesquisar", body: json.encode(body), headers: {"content-type": "application/json; charset=utf-8"});
    if(request.statusCode != 200){
      return;
    }
    var retorno = json.decode(request.body) as List;
  
    resultadosPesquisa = retorno.map((e) => PesquisaItem.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultados da pesquisa')),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount : resultadosPesquisa.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(resultadosPesquisa[index].urlThumbnail),
                  ),
                  title: Text(resultadosPesquisa[index].titulo,style: TextStyle(fontSize: 20.0, color: Colors.black)),
                  subtitle: Text(resultadosPesquisa[index].sinopse),
                  onTap: () async {
                    await Navigator.push(context, new MaterialPageRoute(builder: ((context) => new SearchDetailsPage(resultadosPesquisa[index]))));
                  },
                );
              }
            );
          }
        }
      )
    );
  }
}