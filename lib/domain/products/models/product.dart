import 'package:equatable/equatable.dart';
import 'category.dart';

class BikeModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final dynamic? categoryId;
  final String image;
  final String image3d;
  final dynamic discount;
  final dynamic quantity;

  const BikeModel({
    required this.id,
    required this.name,
    required this.description,
    this.price,
    required this.categoryId,
    required this.image,
    required this.image3d,
    this.discount,
    this.quantity,
  });

  @override
  List<Object?> get props => [id, name,
    description, price, categoryId, image, image3d,discount,quantity
  ];
}
