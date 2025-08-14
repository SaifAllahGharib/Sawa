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

class ChangeNameWidget extends StatefulWidget {
  const ChangeNameWidget({super.key});

  @override
  State<ChangeNameWidget> createState() => _ChangeNameWidgetState();
}

class _ChangeNameWidgetState extends State<ChangeNameWidget> {
  late final TextEditingController _changeNameController;

  @override
  void initState() {
    _changeNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _changeNameController.dispose();
    super.dispose();
  }

  void _changeName(BuildContext context) {
    context.read<ProfileCubit>().changeName(
      _changeNameController.text.trimLeft().trimRight(),
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
            controller: _changeNameController,
            hint: context.tr.hintName,
            onChanged: (value) {
              context.read<ValidationCubit>().validateField(
                'changeName',
                value.trimLeft().trimRight().isNotEmpty &&
                    value.trimLeft().trimRight() !=
                        user.name.toString().trimLeft().trimRight(),
              );
            },
          ),
          20.verticalSpace,
          BlocBuilder<ValidationCubit, ValidationState>(
            builder: (context, validationState) {
              return AppButton(
                onClick: () => _changeName(context),
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
