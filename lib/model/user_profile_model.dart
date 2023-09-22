

class UserProfileModel {
  final int id;
  final User user;
  final String phone;
  final String profileImg;
  final String gender;
  final String age;
  final String weight;
  final String height;
  final String weightUnit;
  final String heightUnit;

  UserProfileModel({
    required this.id,
    required this.user,
    required this.phone,
    required this.profileImg,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.weightUnit,
    required this.heightUnit,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      profileImg: json['profileImg'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      weight: json['weight'] as String,
      height: json['height'] as String,
      weightUnit: json['weight_unit'] as String,
      heightUnit: json['height_unit'] as String,
    );
  }
}

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
