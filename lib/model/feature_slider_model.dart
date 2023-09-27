class SliderItemModel {
  final int id;
  final String image;
  final String link;

  SliderItemModel({
    required this.id,
    required this.image,
    required this.link,
  });

  factory SliderItemModel.fromJson(Map<String, dynamic> json) {
    return SliderItemModel(
      id: json['id'] as int,
      image: json['image'] as String,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'link': link,
    };
  }
}
