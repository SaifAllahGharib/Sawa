import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_state.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_item.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_file_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_gesture_detector_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/home/domain/entities/media_entity.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/cubit/profile/profile_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/profile/presentation/cubit/profile/profile_state.dart';

import '../../../../core/widgets/app_loading_widget.dart';
import '../../../../core/widgets/app_padding_widget.dart';

class DisplayImageProfile extends StatelessWidget {
  const DisplayImageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, mediaState) {
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateProfileState) {
              context.navigator.pop();
            }
          },
          builder: (context, profileState) {
            if (profileState is ProfileLoadingUpdateProfileState) {
              return const AppLoadingWidget();
            }

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
                            onClick: () =>
                                context.read<ProfileCubit>().uploadProfileImage(
                                  MediaEntity(
                                    id: getIt<FirebaseClient>()
                                        .auth
                                        .currentUser!
                                        .uid,
                                    media: [
                                      MediaItem(
                                        path: mediaState.pickedAssets[0].path,
                                        type: MediaType.image,
                                      ),
                                    ],
                                  ),
                                ),
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
                                onTap: () => context.navigator.pop(),
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
      },
    );
  }
}
