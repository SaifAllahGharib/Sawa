import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/clients/firebase_client.dart';
import 'package:sawa/core/di/dependency_injection.dart';
import 'package:sawa/core/enums/reaction_type.dart';
import 'package:sawa/core/extensions/build_context_extensions.dart';
import 'package:sawa/core/extensions/number_extensions.dart';
import 'package:sawa/core/styles/app_styles.dart';
import 'package:sawa/core/widgets/app_gesture_detector_button.dart';
import 'package:sawa/core/widgets/app_loading_widget.dart';
import 'package:sawa/core/widgets/app_svg.dart';
import 'package:sawa/core/widgets/profile_image.dart';
import 'package:sawa/features/home/domain/entities/reaction_entity.dart';
import 'package:sawa/features/user/domain/entity/user_entity.dart';
import 'package:sawa/shared/cubits/reactions/reaction_cubit.dart';
import 'package:sawa/shared/cubits/reactions/reactions_state.dart';

import '../routing/app_route_name.dart';
import '../services/navigation/navigation_service.dart';
import 'app_padding_widget.dart';

class ListUserReactionsPost extends StatefulWidget {
  final List<String> users;
  final List<ReactionEntity> reactions;

  const ListUserReactionsPost({
    super.key,
    required this.users,
    required this.reactions,
  });

  @override
  State<ListUserReactionsPost> createState() => _ListUserReactionsPostState();
}

class _ListUserReactionsPostState extends State<ListUserReactionsPost> {
  @override
  void initState() {
    _getUsersReactionToPostWithReactions();
    super.initState();
  }

  void _getUsersReactionToPostWithReactions() {
    context.read<ReactionCubit>().getUsersReactionToPostWithReactions(
      widget.users,
    );
  }

  void _onTapItem(int index, String uId) {
    NavigationService.I.pushNamed(AppRouteName.profile, arguments: uId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactionCubit, ReactionState>(
      builder: (context, state) {
        if (state.isLoading && state.users.isEmpty) {
          return const AppLoadingWidget();
        }

        return AppPaddingWidget(
          top: 0,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) => _buildUserReactionItem(
                    user: state.users[index],
                    onTap: () => _onTapItem(index, state.users[index].id),
                    userReaction: widget.reactions.map((e) {
                      return ReactionType.fromValue(e.type).icon;
                    }).toList()[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserReactionItem({
    required VoidCallback onTap,
    required UserEntity user,
    required String userReaction,
  }) {
    final isMyProfile =
        getIt<FirebaseClient>().auth.currentUser!.uid == user.id;
    return AppGestureDetectorButton(
      onTap: !isMyProfile ? onTap : () {},
      child: Row(
        children: [
          Stack(
            children: [
              ProfileImage(url: user.image),
              Positioned(
                bottom: -3.r,
                right: -2.r,
                child: Container(
                  width: 25.r,
                  height: 25.r,
                  padding: EdgeInsets.all(2.r),
                  decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.customColor.border,
                      width: 1.r,
                    ),
                  ),
                  child: AppSvg(assetName: userReaction),
                ),
              ),
            ],
          ),
          10.horizontalSpace,
          Expanded(
            child: Text(
              user.name,
              style: AppStyles.s16W500.copyWith(
                color: context.customColor.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
