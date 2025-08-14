import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/features/settings/presentation/widgets/setting_button.dart';

import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../shared/cubits/main/main_cubit.dart';

class ThemeBottomSheetWidget extends StatelessWidget {
  const ThemeBottomSheetWidget({super.key});

  void _changeTheme(BuildContext context, ThemeMode mode) {
    context.navigator.pop();
    context.read<MainCubit>().changeTheme(mode);
  }

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingButton(
            text: context.tr.light,
            onTap: () => _changeTheme(context, ThemeMode.light),
          ),
          SettingButton(
            text: context.tr.dark,
            onTap: () => _changeTheme(context, ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}
