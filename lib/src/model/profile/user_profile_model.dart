// class UserProfile {
//   final String imageUrl;
//   final String name;
//   final String id;
//   final String email;

//   UserProfile({
//     required this.imageUrl,
//     required this.name,
//     required this.id,
//     required this.email,
//   });
// }

class UserProfile {
  final String imageUrl;
  final String name;
  final String id;

  final String email;
  final String phone;
  final String? bio;

  UserProfile({
    required this.imageUrl,
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.bio,
  });

}
