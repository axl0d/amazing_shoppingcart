import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String sku;
  final String name;
  final String description;
  final String image;
  final double price;

  const Product({
    this.id,
    this.sku,
    this.name,
    this.description,
    this.image,
    this.price,
  });

  @override
  List<Object> get props => [
        id,
        sku,
        name,
        description,
        image,
        price,
      ];
}
