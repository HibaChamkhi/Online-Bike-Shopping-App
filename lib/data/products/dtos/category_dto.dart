
import '../../../domain/products/models/category.dart';

class CategoryDto {
  final int id;
  final String name;

  CategoryDto({
    required this.id,
    required this.name,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    print("json $json");
    return CategoryDto(
      id: json['id'] as int,
      name: json['name'] as String,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryDto.fromModel(CategoryModel model) {
    return CategoryDto(
      id: model.id,
      name: model.name,
    );
  }

  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      name: name,
    );
  }
}
