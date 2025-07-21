import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/build_context_extensions.dart';
import 'package:intern_intelligence_social_media_application/core/extensions/number_extensions.dart';

import '../../../../core/styles/app_styles.dart';
import '../../../../core/widgets/app_icon_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
    );
  }
}
