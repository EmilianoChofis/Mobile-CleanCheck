import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/widgets/widgets.dart';

class CcAppBlocListenerTemplate extends StatelessWidget {
  final Widget child;

  const CcAppBlocListenerTemplate({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuildingCubit, BuildingState>(
      listener: (context, state) {
        if (state is BuildingError) {
          CcSnackBarWidget.show(
            context,
            message: state.message,
            snackBarType: SnackBarType.error,
          );
        } else if (state is BuildingSuccess) {
          CcSnackBarWidget.show(
            context,
            message: state.message,
            snackBarType: SnackBarType.success,
          );
        }

        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: child,
    );
  }
}
