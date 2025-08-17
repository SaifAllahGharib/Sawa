import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/widgets/app_padding_widget.dart';
import 'package:sawa/features/user/domain/entity/user_entity.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/utils/app_bottom_sheet.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_placeholder.dart';
import '../../../../core/widgets/app_svg.dart';
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

  void _showChangeBioBottomSheet(BuildContext context) {
    context.navigator.pop();
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

  void _onTapOnBio(BuildContext context) {
    if (userEntity.bio == null || userEntity.bio!.isEmpty) {
      _showChangeBioBottomSheet(context);
    } else {
      AppBottomSheet.showModal(
        context,
        (context) => _buildBioBottomSheetContent(context: context),
      );
    }
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userEntity.bio ?? context.tr.noBio,
                style: AppStyles.s16W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
              if (isMyProfile)
                AppSvg(
                  assetName: AppAssets.edit,
                  colorFilter: ColorFilter.mode(
                    context.customColor.icon!,
                    BlendMode.srcIn,
                  ),
                  width: 20.r,
                  height: 20.r,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBioBottomSheetContent({required BuildContext context}) {
    return AppPaddingWidget(
      top: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBioBottomSheetContentRow(
            context: context,
            text: context.tr.changeBio,
            onTap: () => _showChangeBioBottomSheet(context),
            assetName: AppAssets.edit,
            assetColor: context.customColor.icon!,
          ),
          15.verticalSpace,
          _buildBioBottomSheetContentRow(
            context: context,
            text: context.tr.delete,
            onTap: () {},
            assetName: AppAssets.trash,
            assetColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildBioBottomSheetContentRow({
    required BuildContext context,
    required String text,
    required VoidCallback onTap,
    required String assetName,
    required Color assetColor,
  }) {
    return AppGestureDetectorButton(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppStyles.s18W500.copyWith(
                color: context.customColor.textColor,
              ),
            ),
            AppSvg(
              assetName: assetName,
              width: 20.r,
              height: 20.r,
              colorFilter: ColorFilter.mode(assetColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
