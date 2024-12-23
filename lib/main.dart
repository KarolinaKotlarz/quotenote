import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


import 'home_screen.dart';
import 'models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [QuoteSchema, PersonSchema],
    name: 'isar',
    directory: dir.path,
  );

  int _count = await isar.quotes.count();
  if(_count <= 0) {
    final newQuote = Quote()..body = 'On Earth We\'re Briefly Gorgeous'..isFavorite = false..dateTime =  DateTime.now();

    final newPerson = Person()..name = 'Ocean Vuong'..quotes.add(newQuote);

    await isar.writeTxn(() async {
      await isar.quotes.put(newQuote);
      await isar.persons.put(newPerson);
      await newPerson.quotes.save();
    });
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
