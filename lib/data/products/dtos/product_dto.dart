
import '../../../domain/products/models/product.dart';

class BikeDto {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final String categoryId;
  final String image;
  final dynamic discount;

  BikeDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.discount,
  });

  factory BikeDto.fromJson(Map<String, dynamic> json) {
    return BikeDto(
      id: json['id'],
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['category'] as String,
      image: json['image'] as String,
      discount: (json['discount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': categoryId,
      'image': image,
      'discount': discount,
    };
  }
  factory BikeDto.fromModel(BikeModel model) {
    return BikeDto(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      categoryId: model.categoryId,
      image: model.image,
      discount: model.discount,
    );
  }
  BikeModel toModel() {
    return BikeModel(
      id: id,
      name: name,
      description: description,
      price: price,
      categoryId: categoryId,
      image: image,
      discount: discount,
    );
  }
}

