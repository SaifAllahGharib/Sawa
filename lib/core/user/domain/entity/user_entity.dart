class UserEntity {
  final String id;
  final String? image;
  final String name;
  final String email;
  final String? bio;

  UserEntity({
    required this.id,
    this.image,
    required this.name,
    required this.email,
    this.bio,
  });
}
