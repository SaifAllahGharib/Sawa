import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:intern_intelligence_social_media_application/core/shared/models/media_item.dart';
import 'package:intern_intelligence_social_media_application/core/utils/enums.dart';

@LazySingleton()
class ImagePickerHelper {
  final ImagePicker _picker;

  const ImagePickerHelper(this._picker);

  Future<MediaItem> pickImageFromCamera() async {
    return await _safePick(() async {
      final picked = await _picker.pickImage(source: ImageSource.camera);
      return MediaItem(path: picked?.path ?? '', type: MediaType.image);
    });
  }

  Future<MediaItem> pickImageFromGallery() async {
    return await _safePick(() async {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      return MediaItem(path: picked?.path ?? '', type: MediaType.image);
    });
  }

  Future<List<MediaItem>> pickMultipleImages() async {
    return await _safePickList(() async {
      final pickedList = await _picker.pickMultiImage();
      return pickedList
          .map((e) => MediaItem(path: e.path, type: MediaType.image))
          .toList();
    });
  }

  Future<MediaItem> pickVideoFromCamera() async {
    return await _safePick(() async {
      final picked = await _picker.pickVideo(source: ImageSource.camera);
      return MediaItem(path: picked?.path ?? '', type: MediaType.video);
    });
  }

  Future<MediaItem> pickVideoFromGallery() async {
    return await _safePick(() async {
      final picked = await _picker.pickVideo(source: ImageSource.gallery);
      return MediaItem(path: picked?.path ?? '', type: MediaType.video);
    });
  }

  Future<List<MediaItem>> _safePickList(
    Future<List<MediaItem>> Function() action,
  ) async {
    try {
      return await action();
    } catch (_) {
      return [];
    }
  }

  Future<MediaItem> _safePick(Future<MediaItem> Function() action) async {
    try {
      return await action();
    } catch (_) {
      return MediaItem(path: '', type: MediaType.unknown);
    }
  }
}
