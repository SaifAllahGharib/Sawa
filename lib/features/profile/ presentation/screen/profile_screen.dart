import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_back_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_ink_well_button.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_network_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_remove_focus.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../home/presentation/widgets/post_card.dart';
import '../widgets/text_profile_info_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppRemoveFocus(
        child: SizedBox(
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppPaddingWidget(
                      bottom: 10.r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppBackButton(),
                          AppInkWellButton(
                            onTap: () {},
                            child: Icon(
                              Icons.settings,
                              color: context.customColor.icon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: context.customColor.border),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: AppPaddingWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 135.h,
                        height: 135.h,
                        child: Stack(
                          children: [
                            AppNetworkImage(
                              image:
                                  'https://randomuser.me/api/portraits/men/75.jpg',
                              height: 135.h,
                              width: 135.h,
                              borderRadius: BorderRadius.circular(3000.r),
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: AppInkWellButton(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(5.r),
                                  decoration: BoxDecoration(
                                    color:
                                        context.theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(3000.r),
                                    border: Border.all(
                                      color:
                                          context.customColor.border ??
                                          AppColors.gray,
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
                      TextProfileInfoWidget(
                        onEditTap: () {},
                        name: 'Saif Allah Ghareeb',
                        textStyle: AppStyles.s29W400.copyWith(
                          color: context.customColor.textColor,
                        ),
                      ),
                      5.verticalSpace,
                      TextProfileInfoWidget(
                        onEditTap: () {},
                        name: 'Programmer',
                        textStyle: AppStyles.s16W400.copyWith(
                          color: context.customColor.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(height: 1, color: context.customColor.border),
              ),
              SliverList.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? 12.r : 16.r,
                      bottom: index == 4 ? 16.r : 0,
                    ),
                    child: const PostCard(
                      image: 'https://randomuser.me/api/portraits/men/75.jpg',
                      name: 'name',
                      postedTime: '16',
                      postImage:
                          'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
