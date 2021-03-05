import 'package:tul_shoppingcart/features/cart/data/data_sources/firestore_api_client.dart';
import 'package:tul_shoppingcart/features/cart/data/models/models.dart'
    as Models;
import 'package:tul_shoppingcart/features/cart/domain/entities/entities.dart';
import 'package:tul_shoppingcart/features/cart/domain/repositories/cart_repository.dart';

class FireStoreRepository implements CartRepository {
  FireStoreRepository({FireStoreApiClient client})
      : _client = client ?? FireStoreApiClient();

  final FireStoreApiClient _client;

  @override
  Future<Cart> init() async {
    final cart = await _client.init();
    final products = cart.products
        .map(
          (i) => Item(
            product: Product(
              id: i.product.id,
              image: i.product.image,
              description: i.product.description,
              sku: i.product.sku,
              name: i.product.name,
              price: i.product.price,
            ),
            quantity: i.quantity,
          ),
        )
        .toList();
    return Cart(products: products, cartId: cart.cartId);
  }

  @override
  Future<List<Product>> getProducts() async {
    final products = await _client.getProducts();
    return products
        .map(
          (p) => Product(
            id: p.id,
            image: p.image,
            name: p.name,
            description: p.description,
            sku: p.sku,
            price: p.price,
          ),
        )
        .toList();
  }

  @override
  Future<Cart> updateCart({Cart cart}) async {
    final cartModel = Models.Cart(
        cartId: cart.cartId,
        products: cart.products
            .map(
              (i) => Models.Item(
                product: Models.Product(
                  id: i.product.id,
                  image: i.product.image,
                  name: i.product.name,
                  description: i.product.description,
                  sku: i.product.sku,
                  price: i.product.price,
                ),
                quantity: i.quantity,
              ),
            )
            .toList());
    await _client.updateCart(cartModel);
    return Cart(cartId: cart.cartId, products: cart.products);
  }

  @override
  Future<void> order({int cartId}) async {
    await _client.order(cartId);
  }
}
