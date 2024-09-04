import 'package:equatable/equatable.dart';

class BikeModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final dynamic price;
  final String categoryId;
  final String image;
  final dynamic discount;

  const BikeModel({
    required this.id,
    required this.name,
    required this.description,
    this.price,
    required this.categoryId,
    required this.image,
    this.discount,
  });

  @override
  List<Object?> get props => [id, name,
    description, price, categoryId, image, discount
  ];
}
