import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/features/profile/presentation/cubit/profile/profile_cubit.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import '../../../../shared/cubits/validation/validation_state.dart';

class ChangeBioWidget extends StatefulWidget {
  const ChangeBioWidget({super.key});

  @override
  State<ChangeBioWidget> createState() => _ChangeBioWidgetState();
}

class _ChangeBioWidgetState extends State<ChangeBioWidget> {
  late final TextEditingController _changeBioController;

  @override
  void initState() {
    _changeBioController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _changeBioController.dispose();
    super.dispose();
  }

  void _changeBio(BuildContext context) {
    context.read<ProfileCubit>().changeBio(
      _changeBioController.text.trimLeft().trimRight(),
    );
    context.navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<MainCubit>().user;

    return AppPaddingWidget(
      child: Column(
        children: [
          AppTextFormField(
            controller: _changeBioController,
            hint: context.tr.hintName,
            onChanged: (value) {
              context.read<ValidationCubit>().validateField(
                'changeBio',
                value.trimLeft().trimRight().isNotEmpty &&
                    value.trimLeft().trimRight() !=
                        user.bio.toString().trimLeft().trimRight(),
              );
            },
          ),
          20.verticalSpace,
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, validationState) {
              return AppButton(
                onClick: () => _changeBio(context),
                enabled: validationState.enableButton,
                text: context.tr.update,
              );
            },
          ),
        ],
      ),
    );
  }
}
