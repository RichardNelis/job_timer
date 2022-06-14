import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/database/database.dart';
import 'package:job_timer/app/core/database/database_impl.dart';
import 'package:job_timer/app/modules/login/login_module.dart';
import 'package:job_timer/app/modules/spash/splash_page.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/app/repositories/projects/project_repository_impl.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';
import 'package:job_timer/app/services/auth/auth_service_impl.dart';
import 'package:job_timer/app/services/projects/project_service.dart';

import 'modules/home/home_module.dart';
import 'modules/project/project_module.dart';
import 'services/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<IAuthService>((i) => AuthServiceImpl(database: i())),
        Bind.lazySingleton<IDatabase>((i) => DataBaseImpl()),
        Bind.lazySingleton<IProjectRepository>(
            (i) => ProjectRepositoryImpl(database: i())),
        Bind.lazySingleton<IProjectService>(
            (i) => ProjectServiceImpl(repository: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SplashPage(),
        ),
        ModuleRoute("/login", module: LoginModule()),
        ModuleRoute("/home", module: HomeModule()),
        ModuleRoute("/project", module: ProjectModule()),
      ];
}
