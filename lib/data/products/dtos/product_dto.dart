
import '../../../domain/products/models/product.dart';

class BikeDto {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final String categoryId;
  final String image;
  final String image3d;
  final dynamic discount;
  final dynamic? quantity;

  BikeDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.image3d,
    required this.discount,
     this.quantity,
  });

  factory BikeDto.fromJson(Map<String, dynamic> json) {
    return BikeDto(
      id: json['id'],
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['category'] as String,
      image: json['image'] as String,
      image3d: json['3dImage'] as String,
      discount: (json['discount'] as num).toDouble(),
      quantity: json['quantity'],
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
      '3dImage': image3d,
      'discount': discount,
      'quantity': quantity,
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
      image3d: model.image3d,
      discount: model.discount,
      quantity: model.quantity,
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
      image3d: image3d,
      discount: discount,
      quantity: quantity,
    );
  }
}

