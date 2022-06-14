import 'package:isar/isar.dart';

abstract class IDatabase {
  Future<Isar> openConnection();
}
