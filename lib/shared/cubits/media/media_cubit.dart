import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sawa/core/helpers/image_picker_helper.dart';

import '../../entities/media_item.dart';
import 'media_state.dart';

@injectable
class MediaCubit extends Cubit<MediaState> {
  final ImagePickerHelper _imagePickerHelper;

  MediaCubit(this._imagePickerHelper) : super(MediaState.initial());

  void pickMultipleImages() async {
    final pickedAssets = await _imagePickerHelper.pickMultipleImages();
    if (pickedAssets.isEmpty) return;

    final List<MediaItem> allAssets = [...state.pickedAssets, ...pickedAssets];

    final updatedAssets = _removeDuplicatesByFileName(allAssets);

    emit(state.copyWith(pickedAssets: updatedAssets));
  }

  List<MediaItem> _removeDuplicatesByFileName(List<MediaItem> assets) {
    final seenNames = <String>{};
    final uniqueAssets = <MediaItem>[];

    for (final item in assets) {
      final fileName = item.path.split('/').last.trim();

      if (seenNames.add(fileName)) {
        uniqueAssets.add(item);
      }
    }

    return uniqueAssets;
  }

  void pickImageFromCamera() async {
    final pickedAsset = await _imagePickerHelper.pickImageFromCamera();
    if (pickedAsset.path.isNotEmpty) {
      final updatedAssets = List<MediaItem>.from(state.pickedAssets)
        ..add(pickedAsset);
      emit(state.copyWith(pickedAssets: updatedAssets));
    }
  }

  void pickImageFromGallery() async {
    final pickedAsset = await _imagePickerHelper.pickImageFromGallery();
    if (pickedAsset.path.isNotEmpty) {
      final updatedAssets = List<MediaItem>.from(state.pickedAssets)
        ..add(pickedAsset);
      emit(state.copyWith(pickedAssets: updatedAssets));
    }
  }

  void pickVideoFromCamera() async {
    final pickedAsset = await _imagePickerHelper.pickVideoFromCamera();
    if (pickedAsset.path.isNotEmpty) {
      final updatedAssets = List<MediaItem>.from(state.pickedAssets)
        ..add(pickedAsset);
      emit(state.copyWith(pickedAssets: updatedAssets));
    }
  }

  void pickVideoFromGallery() async {
    final pickedAsset = await _imagePickerHelper.pickVideoFromGallery();
    if (pickedAsset.path.isNotEmpty) {
      final updatedAssets = List<MediaItem>.from(state.pickedAssets)
        ..add(pickedAsset);
      emit(state.copyWith(pickedAssets: updatedAssets));
    }
  }

  void removePickedAsset(int index) {
    final updated = List<MediaItem>.from(state.pickedAssets)..removeAt(index);
    emit(state.copyWith(pickedAssets: updated));
  }

  void removePickedAssetByPath(String path) {
    final updated = state.pickedAssets
        .where((item) => item.path != path)
        .toList();
    emit(state.copyWith(pickedAssets: updated));
  }

  void clearPickedAssets() {
    emit(state.copyWith(pickedAssets: []));
  }
}
