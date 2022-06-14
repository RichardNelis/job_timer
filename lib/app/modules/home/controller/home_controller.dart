import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final IProjectService _projectService;
  final IAuthService _authService;

  HomeController(
      {required IAuthService authService,
      required IProjectService projectService})
      : _authService = authService,
        _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final projects = await _projectService.findByStatus(state.projectStatus);

      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log("Erro ao tentar carregar os projetos", error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading, projects: []));

      final projects = await _projectService.findByStatus(status);

      emit(
        state.copyWith(
          status: HomeStatus.complete,
          projects: projects,
          projectStatus: status,
        ),
      );
    } catch (e, s) {
      log("Erro ao tentar carregar os projetos", error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> updateList() async {
    await filter(ProjectStatus.emAndamento);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
