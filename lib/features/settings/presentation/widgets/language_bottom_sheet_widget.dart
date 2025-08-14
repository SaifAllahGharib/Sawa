import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/features/settings/presentation/widgets/setting_button.dart';

import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../shared/cubits/main/main_cubit.dart';

class LanguageBottomSheetWidget extends StatefulWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  State<LanguageBottomSheetWidget> createState() =>
      _LanguageBottomSheetWidgetState();
}

class _LanguageBottomSheetWidgetState extends State<LanguageBottomSheetWidget> {
  final Map<String, String> _languages = {'ar': 'العربيه', 'en': 'English'};

  void _changeLanguage(BuildContext context, String code) {
    context.navigator.pop();
    context.read<MainCubit>().changeLocale(code);
  }

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      top: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _languages.entries.map((entry) {
          return SettingButton(
            text: entry.value,
            onTap: () => _changeLanguage(context, entry.key),
          );
        }).toList(),
      ),
    );
  }
}
