import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel _projectModel;
  final IProjectService _projectService;

  TaskController({required IProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);

      final task = ProjectTaskModel(name: name, duration: duration);

      await _projectService.addTask(_projectModel.id!, task);

      emit(TaskStatus.success);
    } catch (e, s) {
      log("Erro ao salvar Task", error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
