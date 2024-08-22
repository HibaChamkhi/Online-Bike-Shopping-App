import '../../../domain/products/entities/product.dart';

class BikeModel extends Bike {
  const BikeModel({
    required super.id,
    required super.name,
    super.description,
    super.price,
    super.categoryId,
    super.image,
    super.discount,
  });

  factory BikeModel.fromJson(Map<String, dynamic> json) {
    return BikeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      categoryId: json['category'],
      image: json['image'],
      discount: json['discount'],
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
}
