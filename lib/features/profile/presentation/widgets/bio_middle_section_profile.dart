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
import 'change_bio_widget.dart';

class BioMiddleSectionProfile extends StatelessWidget {
  final UserEntity userEntity;
  final bool isMyProfile;

  const BioMiddleSectionProfile({
    super.key,
    required this.userEntity,
    required this.isMyProfile,
  });

  void _getUser(BuildContext context) {
    context.read<MainCubit>().getUser();
  }

  void _onTapOnBio(BuildContext context) {
    AppBottomSheet.showModal(
      context,
      (context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: getIt<ProfileCubit>()),
          BlocProvider(
            create: (context) => ValidationCubit(requiredFields: {'changeBio'}),
          ),
        ],
        child: const ChangeBioWidget(),
      ),
    );
  }

  void _handleBioState(BuildContext context, ProfileState state) {
    if (state.updateType == ProfileUpdateType.bio && !state.isLoading) {
      _getUser(context);
    } else if (state.errorCode != null) {
      AppSnackBar.showError(context, context.tr.failedToUpdateBio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: _handleBioState,
      builder: (context, state) {
        if (state.isLoading && state.updateType == ProfileUpdateType.bio) {
          return AppPlaceholder(width: 120.w, height: 15.h);
        }

        return AppGestureDetectorButton(
          onTap: () => isMyProfile ? _onTapOnBio(context) : null,
          child: Text(
            userEntity.bio ?? context.tr.noBio,
            style: AppStyles.s16W400.copyWith(
              color: context.customColor.textColor,
            ),
          ),
        );
      },
    );
  }
}
