import 'package:isar/isar.dart';

import '../models/models.dart';

class PersonDatabase {
  final Isar _isar;
  final IsarCollection<Person> _persons;

  PersonDatabase(this._isar) : _persons = _isar.persons;

  Future<void> addPerson(Person person) async {
    await _isar.writeTxn(() async {
      await _persons.put(person);
    });
  }

  Future<List<Person>> getAllPeople() async {
    return await _persons.where().findAll();
  }

  Future<void> updatePerson(Person person) async {
    await _isar.writeTxn(() async {
      await _persons.put(person);
    });
  }

  Future<void> deletePerson(Person person) async {
    await _isar.writeTxn(() async {
      await _persons.delete(person.id);
    });
  }
}
