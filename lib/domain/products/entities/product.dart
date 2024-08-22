import 'package:equatable/equatable.dart';

class Bike extends Equatable {
  final int id;
  final String name;
  final String? description;
  final dynamic? price;
  final String? categoryId;
  final String? image;
  final dynamic? discount;

  const Bike({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.categoryId,
    this.image,
    this.discount,
  });

  @override
  List<Object?> get props => [id, name,
    description, price, categoryId, image, discount
  ];
}
