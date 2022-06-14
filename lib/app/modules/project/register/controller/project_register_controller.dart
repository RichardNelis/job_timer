import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final IProjectService _projectService;

  ProjectRegisterController({required IProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.initial);

  Future<void> register(String name, int estimate) async {
    emit(ProjectRegisterStatus.loading);

    try {
      final projectModel = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.emAndamento,
        tasks: [],
      );

      await _projectService.register(projectModel);

      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log("Erro ao salvar Projecto", error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
