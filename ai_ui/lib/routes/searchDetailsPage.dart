import 'package:ai_ui/models/pesquisaItemModel.dart';
import 'package:flutter/material.dart';

class SearchDetailsPage extends StatefulWidget{
  final PesquisaItem item;

  SearchDetailsPage(this.item);

  @override
  State<StatefulWidget> createState() {
    return _SearchDetailsState(item);
  }
}

class _SearchDetailsState extends State<SearchDetailsPage> {
  final PesquisaItem item;
  _SearchDetailsState(this.item);

  _getField(String title, String initialText, {int lines = 1}){
    var controller = new TextEditingController();
    controller.text = initialText;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 7,
          ),
          TextField(
            readOnly: true,
            controller: controller,
            maxLines: lines,
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item de pesquisa")),
      body: SingleChildScrollView(
        padding: new EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage(item.urlThumbnail)),
            _getField('Autores', item.autores),
            _getField('Título', item.titulo),
            _getField('Sinopse', item.sinopse, lines: 8),
            _getField('Possui PDF disponível', item.isPdfAvailable ? 'Sim' : 'Não'),
        ],
      ),
    ));
  }
}