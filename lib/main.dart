import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Startup Name Generatoriiii",
      home: RandomWords(),
    );
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          //_saved.add(_suggestions[2]);
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      hoverColor: Colors.yellow,
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border_outlined,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _helloWorld() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Hello World"),
          ),
          body: Row(
            children: [
              Text("HI Guys"),
              Image(
                
                image: AssetImage('assets/images/img.png'),
              )
            ],
          ));
    }));
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(context: context, tiles: tiles).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Startup Name Generator"),
          actions: [
            IconButton(onPressed: _pushSaved, icon: Icon(Icons.list)),
          ],
        ),
        body: _buildSuggestions(),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          padding: EdgeInsets.all(1),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Column(
                children: [
                  IconButton(
                      color: Colors.blue,
                      alignment: Alignment.topCenter,
                      onPressed: _helloWorld,
                      icon: Icon(Icons.call)),
                  Container(
                    padding: EdgeInsets.all(1),
                    transformAlignment: Alignment.bottomCenter,
                    child: Text(
                      "CALL",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Colors.blue,
                      alignment: Alignment.topCenter,
                      onPressed: _helloWorld,
                      icon: Icon(Icons.near_me)),
                  Container(
                    padding: EdgeInsets.all(1),
                    transformAlignment: Alignment.bottomCenter,
                    child: Text(
                      "ROUTE",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      color: Colors.blue,
                      alignment: Alignment.topCenter,
                      onPressed: _helloWorld,
                      icon: Icon(Icons.share_rounded)),
                  Container(
                    padding: EdgeInsets.all(1),
                    transformAlignment: Alignment.bottomCenter,
                    child: Text(
                      "SHARE",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        )));
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}
