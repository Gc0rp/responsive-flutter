import 'package:flutter/material.dart';
import 'package:responsive_app/src/people.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 400) {
            return WideLayout();
          } else {
            return NarrowLayout();
          }
        }));
  }
}

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> peopleList = [];

    for (var person in people) {
      peopleList.add(ListTile(
          leading: Image.network(person.picture),
          title: Text(person.name),
          onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        Scaffold(appBar: AppBar(), body: PersonDetail(person))),
              )));

      // return null ? Center(
      //     child: Center(
      //         child: ListView(
      //   children: peopleList,
      // )));
      return Text("Test");
    }
  }
}

class WideLayout extends StatelessWidget {
  const WideLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: NarrowLayout(), color: Colors.red);
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;

  const PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(person.name), Text(person.phone)],
    );
  }
}
