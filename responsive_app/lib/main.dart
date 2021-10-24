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
          visualDensity: VisualDensity.adaptivePlatformDensity),
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
    return PeopleList(
      onPersonTap: (person) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                Scaffold(appBar: AppBar(), body: PersonDetail(person))),
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  const WideLayout({Key? key}) : super(key: key);

  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person? _person;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: PeopleList(
            onPersonTap: (person) => setState(() {
                  _person = person;
                })),
        flex: 2,
      ),
      Expanded(
          child: _person == null ? Placeholder() : PersonDetail(_person!),
          flex: 3)
    ]);
  }
}

class PersonDetail extends StatelessWidget {
  final Person person;

  const PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxHeight > 200) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(person.name),
            Text(person.phone),
            ElevatedButton(
                child: const Text("Contact Me"), onPressed: () => {}),
          ],
        ));
      } else {
        return Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(person.name),
            Text(person.phone),
            ElevatedButton(child: const Text("Contact Me"), onPressed: () => {})
          ],
        ));
      }
    });
  }
}

class PeopleList extends StatelessWidget {
  final void Function(Person) onPersonTap;

  const PeopleList({Key? key, required this.onPersonTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> peopleList = [];

    for (var person in people) {
      peopleList.add(ListTile(
          leading: Image.network(person.picture),
          title: Text(person.name),
          onTap: () => onPersonTap(person)));
    }

    return Center(
        child: Center(
            child: ListView(
      children: peopleList,
    )));
  }
}
