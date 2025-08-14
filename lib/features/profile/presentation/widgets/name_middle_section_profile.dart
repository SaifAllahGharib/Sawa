import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/features/user/domain/entity/user_entity.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_placeholder.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import 'change_name_widget.dart';

class NameMiddleSectionProfile extends StatelessWidget {
  final UserEntity userEntity;
  final bool isMyProfile;

  const NameMiddleSectionProfile({
    super.key,
    required this.userEntity,
    required this.isMyProfile,
  });

  void _getUser(BuildContext context) {
    context.read<MainCubit>().getUser();
  }

  void _onTapOnName(BuildContext context) {
    AppBottomSheet.showModal(
      context,
      (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<ProfileCubit>()),
          BlocProvider(
            create: (context) =>
                ValidationCubit(requiredFields: {'changeName'}),
          ),
        ],
        child: const ChangeNameWidget(),
      ),
    );
  }

  void _handleNameState(BuildContext context, ProfileState state) {
    if (state.updateType == ProfileUpdateType.name && !state.isLoading) {
      _getUser(context);
    } else if (state.errorCode != null) {
      AppSnackBar.showError(context, context.tr.failedToUpdateName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: _handleNameState,
      builder: (context, state) {
        if (state.isLoading && state.updateType == ProfileUpdateType.name) {
          return AppPlaceholder(width: 150.w, height: 15.h);
        }

        return AppGestureDetectorButton(
          onTap: () => isMyProfile ? _onTapOnName(context) : null,
          child: Text(
            userEntity.name.toString(),
            style: AppStyles.s29W400.copyWith(
              color: context.customColor.textColor,
            ),
          ),
        );
      },
    );
  }
}
