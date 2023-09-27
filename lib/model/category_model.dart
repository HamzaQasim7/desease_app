class CategoryModel {
  final int id;
  final String title;
  final int price;
  final String image;

  CategoryModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
    );
  }
}

List<CategoryModel> parseCategories(List<dynamic> json) {
  return json.map((category) => CategoryModel.fromJson(category)).toList();
}
