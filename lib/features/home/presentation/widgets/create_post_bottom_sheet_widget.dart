import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/widgets/bottom_section_create_post_widget.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/shared/cubits/media/media_cubit.dart';
import '../../../../core/shared/cubits/validation/validation_cubit.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../core/widgets/app_remove_focus.dart';
import 'middle_section_create_post_widget.dart';
import 'top_section_create_post_widget.dart';

class CreatePostBottomSheetWidget extends StatelessWidget {
  const CreatePostBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ValidationCubit(requiredFields: {'post'}),
        ),
        BlocProvider(create: (context) => getIt<MediaCubit>()),
      ],
      child: AppRemoveFocus(
        child: AppPaddingWidget(
          top: 0,
          child: Column(
            children: [
              const TopSectionCreatePostWidget(),
              10.verticalSpace,
              const MiddleSectionCreatePostWidget(),
              20.verticalSpace,
              const BottomSectionCreatePostWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
