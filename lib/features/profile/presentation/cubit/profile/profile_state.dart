import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sawa/features/profile/domain/entity/profile_entity.dart';

import '../../../../../core/enums/profile_update_type.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    ProfileEntity? profile,
    String? errorCode,
    @Default(ProfileUpdateType.none) ProfileUpdateType updateType,
  }) = _ProfileState;
}
