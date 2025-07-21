import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/helpers/shared_preferences_helper.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_state.dart';
import 'package:intern_intelligence_social_media_application/core/utils/app_bottom_sheet.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_text_form_field.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/profile_image.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class MiddleSectionProfile extends StatefulWidget {
  const MiddleSectionProfile({super.key});

  @override
  State<MiddleSectionProfile> createState() => _MiddleSectionProfileState();
}

class _MiddleSectionProfileState extends State<MiddleSectionProfile> {
  late final SharedPreferencesHelper _sharedPreferencesHelper;
  late final TextEditingController _changeNameController;

  @override
  void initState() {
    _sharedPreferencesHelper = getIt<SharedPreferencesHelper>();
    _changeNameController = TextEditingController(
      text: _sharedPreferencesHelper.getUserName(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _changeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 135.h,
              height: 135.h,
              child: Stack(
                children: [
                  const ProfileImage(size: 135),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: AppGestureDetectorButton(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          color: context.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(3000.r),
                          border: Border.all(
                            color: context.customColor.border ?? AppColors.gray,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: context.customColor.icon,
                          size: 18.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
            AppGestureDetectorButton(
              onTap: () {
                AppBottomSheet.showModal(context, (context) {
                  return AppPaddingWidget(
                    child:
                        BlocSelector<ValidationCubit, ValidationState, bool?>(
                          selector: (state) =>
                              state.fieldsValidity['changeName'],
                          builder: (context, state) {
                            return Column(
                              children: [
                                AppTextFormField(
                                  controller: _changeNameController,
                                  hint: context.tr.hintName,
                                ),
                                20.verticalSpace,
                                AppButton(
                                  onClick: () {},
                                  enabled: state ?? false,
                                  text: context.tr.update,
                                ),
                              ],
                            );
                          },
                        ),
                  );
                });
              },
              child: Text(
                _sharedPreferencesHelper.getUserName() ?? '',
                style: AppStyles.s29W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
            ),
            if (_sharedPreferencesHelper.getUserBio() != null) 5.verticalSpace,
            if (_sharedPreferencesHelper.getUserBio() != null)
              Text(
                _sharedPreferencesHelper.getUserBio() ?? '',
                style: AppStyles.s16W400.copyWith(
                  color: context.customColor.textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
