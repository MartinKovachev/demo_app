import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  @override
  List<Object> get props => [
        id,
        title,
        description,
        price,
        thumbnail,
      ];
}
