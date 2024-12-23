import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:quotenote/person_details.dart';
import 'package:quotenote/quote_details.dart';

import 'models/models.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'Quotes', Icon(Icons.chat_outlined), Icon(Icons.chat)),
  ExampleDestination(
      'Favorites', Icon(Icons.star_border), Icon(Icons.star)),
  ExampleDestination(
      'People', Icon(Icons.people_outline), Icon(Icons.people)),
  ExampleDestination(
      'Stats', Icon(Icons.assessment_outlined), Icon(Icons.assessment)),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final isar = Isar.getInstance('isar');

  Future<List<Person>?>? getPeople() async {
    return await isar?.persons.where().findAll();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
    // TODO: maybe change appearance of android top bar to be transparent
  }

  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'QUOTEBOOK',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Pages',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations.map(
                (ExampleDestination destination) {
              return NavigationDrawerDestination(
                label: Text(destination.label),
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Divider(),
          ),
          NavigationDrawerDestination(
            label: Text('Settings'),
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: ListView(
              children: <Widget>[
                SearchAnchor.bar(
                    barLeading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: openDrawer,
                    ),
                    barTrailing: [Icon(Icons.search)],
                    barHintText: "Search for quotes...",
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<Widget>.generate(
                        5,
                            (int index) {
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text('Initial list item $index'),
                          );
                        },
                      );
                    }),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "People",
                          style: TextStyle(fontSize: 20),
                        ),
                        //Switch(value: false, onChanged: (bool value) {})
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 120.0,
                    child: FutureBuilder<List<Person?>?>(
                        future: getPeople(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final people = snapshot.data ?? [];
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: people.length,
                              itemBuilder: (context, index) {
                                final person = people[index];
                                return InkWell(
                                  onTap: () {},
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PersonDetailsPage()
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: SizedBox(
                                        width: 80.0,
                                        height: 50.0,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Container(
                                                  margin: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue,
                                                  ),
                                                )
                                            ),
                                            Expanded(child: Text(person!.name)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        }
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Quotes",
                          style: TextStyle(fontSize: 20),
                        ),
                        //Switch(value: false, onChanged: (bool value) {})
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 3 / 4),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridTile(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Aug 12, 21:17', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Icon(Icons.star, size: 18,)
                                      ]
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                      padding: EdgeInsets.only(top: 4.0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 7,
                                      )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        spacing: 8.0,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              side: const BorderSide(width: 1),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 2.0,
                                                  horizontal: 14.0),
                                              child: Text('Name'),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              side: const BorderSide(width: 1),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 2.0,
                                                  horizontal: 14.0),
                                              child: Text('+2'),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuoteDetailsPage()
              ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<Widget> _getCards() {
  List<Widget> list = List<Widget>.empty(growable: true);
  int i = 0;
  for (i = 0; i < 19; i++) {
    list.add(
      Card(
        color: Colors.blue[i * 100],
        child: SizedBox(
          width: 180.0,
          height: i * 50.0 % 200,
          child: Column(
            children: [
              Expanded(child: Text("$i")),
              Expanded(child: Text("$i")),
            ],
          ),
        ),
      ),
    );
  }
  return list;
}
