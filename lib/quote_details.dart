import 'package:flutter/material.dart';

/*
  TODO: make datetime controls prettier (if possible)
  TODO: make textfield function as desired (also not edit when collapsing bottom bar)
    - autofocus
    - collapse/stop editing on enter, back, maybe tap outside..?
    -
  TODO: rich text formatting?
 */

class QuoteDetailsPage extends StatefulWidget {
  const QuoteDetailsPage({Key? key}) : super(key: key);

  @override
  _QuoteDetailsPageState createState() => _QuoteDetailsPageState();
}

class _QuoteDetailsPageState extends State<QuoteDetailsPage> with WidgetsBindingObserver {
  double _height = 60;
  bool isCollapsed = true;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final quoteTextController = TextEditingController();
  late FocusNode quoteFocusNode;

  @override
  void initState() {
    super.initState();

    quoteFocusNode = FocusNode();
  }

  @override
  void dispose() {
    quoteTextController.dispose();
    quoteFocusNode.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );});

    if (pickedTime != null && pickedTime != selectedTime )
      setState(() {
        selectedTime = pickedTime;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: quoteFocusNode,
                    controller: quoteTextController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(hintText: 'start typing...'),
                  ),
                ),
              ),
              TapRegion(
                onTapOutside: (event) {
                  setState(() {
                    _height = 60;
                    isCollapsed = true;
                  });
                },
                child: Container(
                  height: _height,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 2,
                        )),
                  ),
                  child: isCollapsed
                      ? _buildBottomBarCollapsed()
                      : _buildBottomBarExpanded(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBarCollapsed() {
    return Row(
      children: [
        SizedBox(
          height: 70,
          child: IconButton(
            onPressed: () {
              setState(() {
                _height = 250;
                isCollapsed = false;
              });
            },
            icon: const Icon(Icons.add),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return FilterChip(
                label: Text('name'),
                selected: false,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                    } else {}
                  });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10,
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TapRegion(
                onTapInside: (event) {
                  _selectDate(context);
                },
                child: Text('Aug 21'),
              ),
              TapRegion(
                onTapInside: (event) {
                  _selectTime(context);
                },
                child: Text('18:37'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBarExpanded() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.clear),
              ),
              Text('Select names'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              FilterChip(
                label: Text('exercise.name'),
                selected: false,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                    } else {}
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}