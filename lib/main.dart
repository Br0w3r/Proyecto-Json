import 'package:flutter/material.dart';
import 'package:flutter_proyecto/icono_string_util.dart';
import 'package:flutter_proyecto/provider_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joshua Landa',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proyecto Json"),
      ),

      body: _lista(context),
      );
  }

  Widget _lista(BuildContext context){
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        return ListView(
          children: _listItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _listItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(Icons.keyboard_arrow_right_outlined),
        onTap: () {
          _MessageSnack(context, opt['texto']);
        },
      );
      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }

  void _MessageSnack(BuildContext context, String opt) {
    final snackBar = SnackBar(content: Text(opt));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
