import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/validation/validation_cubit.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';

import '../widgets/app_bar_profile.dart';
import '../widgets/bottom_section_profile.dart';
import '../widgets/middle_section_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValidationCubit(requiredFields: {'changeName'}),
      child: AppScaffold(
        child: SizedBox(
          width: double.infinity,
          child: CustomScrollView(
            slivers: [
              const AppBarProfile(),
              const MiddleSectionProfile(),
              SliverToBoxAdapter(
                child: Divider(height: 1, color: context.customColor.border),
              ),
              const BottomSectionProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
