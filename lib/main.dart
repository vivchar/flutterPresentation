import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TomskSoft',
      home: HomePage(),
//      home: Center(child: Text("Спасибо за внимание!", textAlign: TextAlign.center),)
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final List<String> items = List.generate(4, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: onAddItem,
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('TomskSoft'),
          leading: Icon(Icons.people),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            )
          ],
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, position) {
              var item = items[position];
              return Dismissible(
                key: Key(item),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  onRemoveItem(position);
                },
                child: ListTile(
                  title: Text(item),
                  subtitle: Text("subtitle"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  onTap: () {
                    onEditItem(position);
                  },
                ),
              );
            }));
  }

  onAddItem() async {
    var name = await openSecondPage("");

//    var name = await showDialog(
//        context: context,
//        builder: (context) {
//          var controller = TextEditingController();
//          return AlertDialog(
//            title: Text('Please enter a value'),
//            content: TextField(controller: controller),
//            actions: <Widget>[
//              FlatButton(
//                child: Text("ADD"),
//                onPressed: () {
//                  Navigator.of(context).pop(controller.text);
//                },
//              )
//            ],
//          );
//        });

    if (name != null) {
      setState(() {
        items.add(name);
      });
    }
  }

  onRemoveItem(int position) {
    setState(() {
      items.removeAt(position);
    });
  }

  Future<String> openSecondPage(String item) async {
    var name = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondRoute(item: item)),
    );
    return name;
  }

  void onEditItem(int position) async {
    var item = items[position];
    var name = await openSecondPage(item);

    setState(() {
      items.removeAt(position);
      items.insert(position, name == null ? "" : name);
    });
  }
}

class SecondRoute extends StatefulWidget {
  final String item;

  SecondRoute({Key key, @required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SecondRouteState();
  }
}

class SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: widget.item);

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter a value"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "value"),
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
