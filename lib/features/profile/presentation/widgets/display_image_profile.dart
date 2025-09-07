import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_colors.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/widgets/app_button.dart';
import 'package:sawa/core/widgets/app_file_image.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_scaffold.dart';
import 'package:sawa/features/post/data/models/media_model.dart';

import '../../../../core/enums/media_type.dart';
import '../../../../core/services/navigation/navigation_service.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../../shared/cubits/media/media_state.dart';
import '../cubit/profile/profile_cubit.dart';

class DisplayImageProfile extends StatelessWidget {
  const DisplayImageProfile({super.key});

  void _uploadImage(BuildContext context, MediaState mediaState) {
    context.read<ProfileCubit>().updateProfileImage(
      MediaModel(
        path: mediaState.pickedAssets[0].path,
        type: MediaType.image.toString(),
      ),
    );
    NavigationService.I.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, mediaState) {
        return AppScaffold(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPaddingWidget(
                  bottom: 10.r,
                  child: Row(
                    children: [
                      AppButton(
                        width: 60.w,
                        enabled: true,
                        borderRadius: BorderRadius.circular(10.r),
                        padding: EdgeInsets.symmetric(vertical: 2.r),
                        onClick: () => _uploadImage(context, mediaState),
                        text: context.tr.save,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            context.tr.viewProfilePicture,
                            style: AppStyles.s16W600,
                          ),
                          10.horizontalSpace,
                          AppGestureDetectorButton(
                            onTap: () => NavigationService.I.pop(),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20.r,
                              color: context.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppColors.gray.withValues(alpha: 0.5),
                ),
                20.verticalSpace,
                Align(
                  alignment: Alignment.center,
                  child: AppFileImage(
                    image: mediaState.pickedAssets[0].path,
                    borderRadius: BorderRadius.zero,
                    height: 300.h,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
