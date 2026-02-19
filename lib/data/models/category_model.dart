import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({required super.id, required super.name, super.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["title"] ?? "",
      image: json["image"],
    );
  }
}
