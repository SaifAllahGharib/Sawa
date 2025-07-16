import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/clients/firebase_client.dart';
import 'package:intern_intelligence_social_media_application/core/di/dependency_injection.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_colors.dart';
import 'package:intern_intelligence_social_media_application/core/styles/app_styles.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_network_image.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_padding_widget.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_remove_focus.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/widgets/post_card.dart';

import '../../../../core/widgets/app_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _postController;

  @override
  void initState() {
    _postController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _getUser() {
    context.read<HomeCubit>().getUser(
      getIt<FirebaseClient>().auth.currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: AppRemoveFocus(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              automaticallyImplyLeading: false,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              title: Text(
                'Hoki',
                style: AppStyles.s22W600.copyWith(
                  color: context.theme.primaryColor,
                  letterSpacing: 15,
                ),
              ),
              actions: [
                AppIconButton(icon: Icons.chat_outlined, onPressed: () {}),
                10.horizontalSpace,
                AppIconButton(icon: Icons.add_circle_outline, onPressed: () {}),
                10.horizontalSpace,
              ],
            ),
            SliverToBoxAdapter(
              child: AppPaddingWidget(
                top: 8.r,
                bottom: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: false,
                          hintText: context.tr.whateYouThinking,
                          contentPadding: EdgeInsets.all(10.r),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000.r),
                            borderSide: const BorderSide(color: AppColors.gray),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000.r),
                            borderSide: const BorderSide(color: AppColors.gray),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1000.r),
                            borderSide: BorderSide(
                              color: context.theme.primaryColor,
                              width: 1.5.r,
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    AppNetworkImage(
                      image: 'https://randomuser.me/api/portraits/men/75.jpg',
                      width: 45.h,
                      height: 45.h,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
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
              }, childCount: 5),
            ),
          ],
        ),
      ),
    );
  }
}
