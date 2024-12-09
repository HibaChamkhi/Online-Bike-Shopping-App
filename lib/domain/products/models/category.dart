import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final dynamic id;
  final String name;

  const CategoryModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name,
  ];
}
