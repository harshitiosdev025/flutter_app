import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Vehicle> vehicles = [
    new Vehicle(
      'Bike',
      ['Vehicle no. 1', 'Vehicle no. 2', 'Vehicle no. 7', 'Vehicle no. 10'],
      Icons.motorcycle,
    ),
    new Vehicle(
      'Cars',
      ['Vehicle no. 3', 'Vehicle no. 4', 'Vehicle no. 6'],
      Icons.directions_car,
    ),
  ];
  final int max = 10;
  int selected = -1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(
          key: Key('builder ${selected.toString()}'),
          builder: (context){
            return ListView(
              children: <Widget>[
                for(int i = 0; i < vehicles.length; i++)
                  ExpansionTile(
                    key: Key(i.toString()),
                    title: Text('Tile ${i+1}'),
                    initiallyExpanded: i==selected,
                    onExpansionChanged: (expanded){
                      if(expanded)
                        setState(() {
                          selected = i;
                        });
                      else setState(() {
                        selected = -1;
                      });


                    },
                    children: [
                      new Column(
                        children: _buildExpandableContent(vehicles[i]),
                      ),
                    ],
                  )
              ],
            );
          },
        )
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents)
      columnContent.add(
        new ListTile(
          title: new Text(content, style: new TextStyle(fontSize: 18.0),),
          leading: new Icon(vehicle.icon),
        ),
      );

    return columnContent;
  }
}


class Vehicle {
  final String title;
  List<String> contents = [];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);
}