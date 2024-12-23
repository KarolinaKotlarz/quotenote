import 'package:isar/isar.dart';

part 'models.g.dart';

@collection
class Quote {
  Id id = Isar.autoIncrement;

  late bool isFavorite;

  @Index()
  late DateTime dateTime;

  String? body;

  final people = IsarLinks<Person>();
}

@collection
class Person {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  @Backlink(to: 'people')
  final quotes = IsarLinks<Quote>();
}