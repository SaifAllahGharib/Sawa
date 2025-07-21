import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/shared/cubits/media/media_cubit.dart';

import '../../../../core/shared/cubits/validation/validation_cubit.dart';
import '../../../../core/shared/cubits/validation/validation_state.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_gesture_detector_button.dart';

class BottomSectionCreatePostWidget extends StatelessWidget {
  const BottomSectionCreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocSelector<ValidationCubit, ValidationState, bool?>(
            selector: (state) => state.enableButton,
            builder: (context, state) {
              return AppButton(
                enabled: state ?? false,
                onClick: () {},
                text: context.tr.post,
              );
            },
          ),
        ),
        10.horizontalSpace,
        AppGestureDetectorButton(
          onTap: () => context.read<MediaCubit>().pickMultipleImages(),
          child: Icon(
            Icons.image_outlined,
            size: 30.r,
            color: context.customColor.icon,
          ),
        ),
      ],
    );
  }
}
