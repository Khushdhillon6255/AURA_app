// Eh class dasdi hai ki ek user de kol ki-ki jaankari hovegi
class UserModel {
  final String uid; // Har user di ek unique ID
  final String name;
  final String email;
  final String profileImageUrl;
  final String height;
  final String weight;
  final String dob;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.height,
    required this.weight,
    required this.dob,
  });
}