import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawa/core/utils/enums.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../shared/cubits/main/main_cubit.dart';
import '../cubit/profile/profile_cubit.dart';
import '../cubit/profile/profile_state.dart';
import 'my_profile_view.dart';
import 'user_profile_view.dart';

class ProfileScreen extends StatefulWidget {
  final String uId;

  const ProfileScreen({super.key, required this.uId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getProfile();
    super.initState();
  }

  void _handleState(BuildContext context, ProfileState state) {
    if (state.updateType == ProfileUpdateType.deletePost) {
      AppSnackBar.showSuccess(context, context.tr.postDeleteSuccess);
    } else if (state.errorCode != null) {
      AppSnackBar.showError(context, context.tr.failureToGetProfile);
    }
  }

  void _getProfile() {
    context.read<ProfileCubit>().getProfile(widget.uId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final user = context.watch<MainCubit>().user;

    return AppScaffold(
      child: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          color: context.theme.primaryColor,
          onRefresh: () async => _getProfile(),
          child: widget.uId == user.id
              ? MyProfileView(handleState: _handleState, userEntity: user)
              : UserProfileView(handleState: _handleState),
        ),
      ),
    );
  }
}
