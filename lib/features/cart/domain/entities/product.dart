import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String sku;
  final String name;
  final String description;
  final String image;

  const Product({this.id, this.sku, this.name, this.description, this.image});

  @override
  List<Object> get props => [
        id,
        sku,
        name,
        description,
        image,
      ];
}
