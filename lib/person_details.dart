import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PersonDetailsPage extends StatefulWidget {
  const PersonDetailsPage({Key? key}) : super(key: key);

  @override
  _PersonDetailsPageState createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () => Navigator.of(context).pop(),
      //     icon: const Icon(Icons.arrow_back),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.push_pin_outlined),
      //     ),
      //     MenuAnchor(
      //       builder: (BuildContext context, MenuController controller,
      //           Widget? child) {
      //         return IconButton(
      //           onPressed: () {
      //             if (controller.isOpen) {
      //               controller.close();
      //             } else {
      //               controller.open();
      //             }
      //           },
      //           icon: const Icon(Icons.more_vert),
      //           tooltip: 'Show menu',
      //         );
      //       },
      //       menuChildren: List<MenuItemButton>.generate(
      //         3,
      //         (int index) => MenuItemButton(
      //           onPressed: () => {},
      //           //setState(() => selectedMenu = SampleItem.values[index]),
      //           child: Text('Item ${index + 1}'),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            stretch: true,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Person Name', style: TextStyle(
                color: Colors.black, //TODO: fix
              ),),
              background: Card(),
              stretchModes: [
                StretchMode.fadeTitle
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                      child: Column(
                        children: <Widget>[
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
                          GridView.builder(
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Aug 12, 21:17',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 18,
                                                )
                                              ]),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

