import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;

  final String label;
  final VoidCallback onPressed;

  const ButtonWithLoader({
    super.key,
    required this.label,
    required this.onPressed,
    required this.selector,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
      bloc: bloc,
      selector: selector,
      builder: (context, showLoading) {
        return ElevatedButton(
          style: !showLoading
              ? ElevatedButton.styleFrom()
              : ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  onSurface: Colors.blue,
                ),
          onPressed: showLoading ? null : onPressed,
          child: Visibility(
            visible: showLoading,
            replacement: Text(label),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
