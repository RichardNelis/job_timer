import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseImpl implements IDatabase {
  Isar? _databaseInstance;

  @override
  Future<Isar> openConnection() async {
    try {
      if (_databaseInstance == null) {
        final dir = await getApplicationDocumentsDirectory();

        _databaseInstance = await Isar.open(
          schemas: [
            ProjectTaskSchema,
            ProjectSchema,
          ],
          directory: dir.path,
          inspector: true,
        );
      }

      return _databaseInstance!;
    } catch (e, s) {
      log("Erro ao abrir connection", error: e, stackTrace: s);
      return openConnection();
    }
  }
}
