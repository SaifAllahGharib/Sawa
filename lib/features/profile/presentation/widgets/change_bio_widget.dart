import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_snack_bar.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_button_loading.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/cubit/profile/profile_state.dart';
import 'package:intern_intelligence_social_media_application/features/user/domain/entity/user_entity.dart';
import 'package:intern_intelligence_social_media_application/features/user/presentation/cubit/user/user_state.dart';

import '../../../../core/di/dependency_injection.dart';
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

  @override
  Widget build(BuildContext context) {
    final mainState = context.watch<MainCubit>().state;
    final userState = mainState.userState;
    UserEntity? user;

    if (userState is UserSuccessState) {
      user = userState.user;
    }

    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: AppPaddingWidget(
        child: Column(
          children: [
            if (user != null)
              AppTextFormField(
                controller: _changeBioController,
                hint: context.tr.hintName,
                onChanged: (value) {
                  context.read<ValidationCubit>().validateField(
                    'changeBio',
                    value.trimLeft().trimRight().isNotEmpty &&
                        value.trimLeft().trimRight() !=
                            user?.bio.toString().trimLeft().trimRight(),
                  );
                },
              ),
            20.verticalSpace,
            BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, validationState) {
                return BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileFailureState) {
                      context.navigator.pop();
                      AppSnackBar.showError(context, state.code);
                    } else if (state is ProfileUpdatedState) {
                      context.read<MainCubit>().getUser();
                      context.navigator.pop();
                      AppSnackBar.showSuccess(
                        context,
                        context.tr.updateBioSuccess,
                      );
                    }
                  },
                  builder: (context, profileState) {
                    if (profileState is ProfileLoadingUpdateProfileState) {
                      return const AppButtonLoading();
                    }

                    return AppButton(
                      onClick: () => context.read<ProfileCubit>().changeBio(
                        _changeBioController.text.trimLeft().trimRight(),
                      ),
                      enabled: validationState.enableButton,
                      text: context.tr.update,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
