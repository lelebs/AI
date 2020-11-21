import 'package:ai_ui/models/dataModel.dart';

import '../constants.dart' as Constants;
import 'package:ai_ui/services/router.service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

final List<DataModel> listao = [new DataModel('titulozada','descrito')];

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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: Center(
        child: const Text(
          'Bem vindo ao AI \n \nPressione o ícone da câmera para escanear',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          locator<NavigationService>(). navigateTo(Constants.TextRecognizerPage);
        },
        child: Icon(Icons.camera_alt),
      ),
    ),
    Stack(
      children: [
        new Container(
          child:
            ListView.builder(
              itemCount: listao.length,
              itemBuilder: (BuildContext context, int index) {  
                return Stack(children: [
                  Container(
                    child: Text(listao[index].titulo),
                    height: 50,
                  ),
                  Container(
                    child: Text(listao[index].descricao),
                    height: 50,
                  ),
                ]);
              },
            )
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
