part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, complete, failure }

class ProjectDetailState extends Equatable {
  final ProjectModel? projectModel;
  final ProjectDetailStatus status;

  const ProjectDetailState._({this.projectModel, required this.status});

  const ProjectDetailState.initial()
      : this._(status: ProjectDetailStatus.initial);

  ProjectDetailState copyWith({
    ProjectModel? projectModel,
    ProjectDetailStatus? status,
  }) {
    return ProjectDetailState._(
      projectModel: projectModel ?? this.projectModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [projectModel, status];
}
