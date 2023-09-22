class SubUserModel {
  final int id;
  final String? profileImg;
  final String name;
  final String relationShip;
  final String color;
  final String gender;
  final String age;
  final String weight;
  final String height;
  final String weightUnit;
  final String heightUnit;
  final int user;

  SubUserModel({
    required this.id,
    this.profileImg,
    required this.name,
    required this.relationShip,
    required this.color,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.weightUnit,
    required this.heightUnit,
    required this.user,
  });

  factory SubUserModel.fromJson(Map<String, dynamic> json) {
    return SubUserModel(
      id: json['id'] as int,
      profileImg: json['profileImg'] as String?,
      name: json['name'] as String,
      relationShip: json['relation_ship'] as String,
      color: json['color'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      weight: json['weight'] as String,
      height: json['height'] as String,
      weightUnit: json['weight_unit'] as String,
      heightUnit: json['height_unit'] as String,
      user: json['user'] as int,
    );
  }
}
