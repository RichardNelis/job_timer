import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  final ProjectRegisterController controller;

  const ProjectRegisterPage({super.key, required this.controller});

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _estimativaEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _estimativaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            Modular.to.pop();
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert("Erro ao salvar projeto").show();
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Criar novo projeto",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text("Nome do Projeto"),
                  ),
                  validator: Validatorless.required("Nome obrigatório"),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _estimativaEC,
                  decoration: const InputDecoration(
                    label: Text("Estimativa de Horas"),
                  ),
                  keyboardType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required("Estimativa obrigatório"),
                    Validatorless.number("Permitido somente números")
                  ]),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: size.width,
                  height: 49,
                  child: ButtonWithLoader<ProjectRegisterController,
                      ProjectRegisterStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == ProjectRegisterStatus.loading,
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        final name = _nameEC.text;
                        final estimate = int.parse(_estimativaEC.text);

                        await widget.controller.register(name, estimate);
                      }
                    },
                    label: "Salvar",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
