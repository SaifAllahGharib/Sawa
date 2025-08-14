import '../constants/reaction_type.dart';

class ReactionParams {
  final String postId;
  final ReactionType type;

  ReactionParams({required this.postId, required this.type});
}
