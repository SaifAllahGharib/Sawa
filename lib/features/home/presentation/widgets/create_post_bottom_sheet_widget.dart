import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/features/home/presentation/widgets/bottom_section_create_post_widget.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/app_padding_widget.dart';
import '../../../../shared/cubits/media/media_cubit.dart';
import '../../../../shared/cubits/validation/validation_cubit.dart';
import 'middle_section_create_post_widget.dart';
import 'top_section_create_post_widget.dart';

class CreatePostBottomSheetWidget extends StatefulWidget {
  const CreatePostBottomSheetWidget({super.key});

  @override
  State<CreatePostBottomSheetWidget> createState() =>
      _CreatePostBottomSheetWidgetState();
}

class _CreatePostBottomSheetWidgetState
    extends State<CreatePostBottomSheetWidget> {
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ValidationCubit(requiredFields: {'post'}),
        ),
        BlocProvider(create: (context) => getIt<MediaCubit>()),
      ],
      child: AppPaddingWidget(
        top: 0,
        child: Column(
          children: [
            const TopSectionCreatePostWidget(),
            10.verticalSpace,
            MiddleSectionCreatePostWidget(postController: _postController),
            20.verticalSpace,
            BottomSectionCreatePostWidget(postController: _postController),
          ],
        ),
      ),
    );
  }
}
