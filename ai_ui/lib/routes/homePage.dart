import 'dart:convert';

import 'package:ai_ui/models/dropDownModel.dart';
import 'package:ai_ui/models/pesquisaItemModel.dart';
import 'package:ai_ui/routes/pesquisaResultsPage.dart';
import 'package:http/http.dart' as Http;
import 'package:ai_ui/models/pesquisaModel.dart';

import '../constants.dart' as Constants;
import 'package:ai_ui/services/router.service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

List<PesquisaModel> pesquisasRealizadas = List<PesquisaModel>();

List<DropDownModel> dropDownSource = List.from([new DropDownModel(1, 'Livro'), DropDownModel(2,'Filme')]);


class HomePage extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  BuildContext thatContext;

  int _selectedIndex = 0;
  static TextEditingController textController = TextEditingController(text: 'Desenvolvido por: Leandro Gabatel');
  static TextEditingController versionTextController = TextEditingController(text: 'Versão 1.0');

  static Future<dynamic> _getData() async {
    var httpRequest = await Http.get(Constants.DataAPILink + "obterpesquisas", headers: {"content-type": "application/json; charset=utf-8"});
    if(httpRequest.statusCode == 200){
      var body = json.decode(httpRequest.body) as List;
      pesquisasRealizadas = body.map((e) => PesquisaModel.fromJson(e)).toList();
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: Center(
        child: const Text(
          'Bem vindo ao AI \n \nPressione o ícone da câmera para escanear',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await locator<NavigationService>().navigateTo(Constants.TextRecognizerPage);
        },
        child: Icon(Icons.camera_alt),
      ),
    ),
    Stack(
      children: [
        FutureBuilder(
        future: _getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount : pesquisasRealizadas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.book),
                  ),
                  title: Text(pesquisasRealizadas[index].textoPesquisa, style: TextStyle(fontSize: 20.0, color: Colors.black)),
                  subtitle: Text(dropDownSource.firstWhere((element) => element.id == pesquisasRealizadas[index].idTipoPesquisa).descricao),
                  onTap: () async {
                    var idPesquisar = pesquisasRealizadas[index].id;
                    var httpRequest = await Http.get(Constants.DataAPILink + "obterpesquisa/" + idPesquisar.toString(), headers: {"content-type": "application/json; charset=utf-8"});
                    if(httpRequest.statusCode == 200){
                      var bodyRetorno = json.decode(httpRequest.body) as List;
                      var listaResultados = bodyRetorno.map((e) => PesquisaItem.fromJson(e)).toList();
                      await Navigator.push(context, new MaterialPageRoute(builder: ((context) => new PesquisaResultsPage(null, presetResults: listaResultados))));
                    }
                  },
                );
              }
            );
          }
        }
      )
    ],
      
    ),
    SingleChildScrollView(
      padding: new EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
           readOnly: true,
           controller: textController,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
           readOnly: true,
           controller: versionTextController,
          )
        ],
      ) ,
    )

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Sobre',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
