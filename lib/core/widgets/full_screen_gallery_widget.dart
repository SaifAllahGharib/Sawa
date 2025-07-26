import 'package:flutter/material.dart';
import 'package:intern_intelligence_social_media_application/core/widgets/app_scaffold.dart';

import 'app_network_image.dart';

class FullScreenGalleryWidget extends StatelessWidget {
  final String image;

  const FullScreenGalleryWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.black,
      child: InteractiveViewer(
        child: Center(child: AppNetworkImage(image: image)),
      ),
    );
  }
}
