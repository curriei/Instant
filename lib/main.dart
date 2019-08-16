import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instant',
      theme: ThemeData(
        primaryColor: Colors.blue,
        ),
      home: Container(),
    );
  }
}

class Restaurant {
  String name;
  int ID;

  Restaurant(String name, int ID) {
    this.name = name;
    this.ID = ID;
  }

  String get res_name {
    return name;
  }

  int get res_ID {
    return ID;
  }
}
//create class for restaurants, create list of restaurant objects (name, ID), pass restaurant objects to suggested, when liked pass ID to saved, display names by calling objects

class ContainerState extends State<Container> {
  final List<Restaurant> _res = <Restaurant>[Restaurant("a", 0), Restaurant("b", 1), Restaurant("c", 2), Restaurant("d", 3), Restaurant("e", 4), Restaurant("f", 5), Restaurant("g", 6), Restaurant("h", 7), Restaurant("i", 8)];
  final List<Restaurant> _suggestions = <Restaurant>[];
  static final List<String> _saved = <String>[];
  static final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.add(_res[index]);
        }
        return _buildRow(index);
        });
  }

  Widget _buildRow(index) {
    final bool alreadySaved = _saved.contains(_res[index].res_name);
    return ListTile(
      title: Text(
        _res[index].res_name,
        style: _biggerFont,
        ),
      //conditionals for icon display state
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(_res[index].res_name);
            } else {
              _saved.add(_res[index].res_name);
            }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OmniDrawer(),
      appBar: AppBar(
        title: Text('Welcome to Instant'),
        ),
      body: _buildSuggestions(),
      );
  }
}

class OmniDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget> [
          DrawerHeader(
            child: Text('Header'),
            decoration: BoxDecoration(
              color: Colors.orange
              ),
            ),
          ListTile(
            title: Text('HOME'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          Divider(),
          ListTile(
            title: Text('FAVOURITES'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites()));
            },
          ),
        ],
      )
    );
  }
}

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = ContainerState._saved.map(
      (String res) {
        return ListTile(
          title: Text(
            res,
            style: ContainerState._biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return Scaffold(
      drawer: OmniDrawer(),
      appBar: AppBar(title: Text("Favourites"),),
      body: ListView(children: divided),
    );
  }
}

class Container extends StatefulWidget {
  @override
  ContainerState createState() => ContainerState();
}