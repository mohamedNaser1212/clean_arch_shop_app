import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

abstract class CartLocalDataSource {
  const CartLocalDataSource();
  Future<List<CartEntity>> getCart();
  Future<void> saveCart(List<CartEntity> cart);
  Future<void> removeCartItem(num productId);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final LocalStorageHelper hiveHelper;

  const CartLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<List<CartEntity>> getCart() async {
    final cartItems =
        await hiveHelper.loadData<CartEntity>(HiveBoxesNames.kCartBox);
    return cartItems.cast<CartEntity>().toList();
  }

  @override
  Future<void> saveCart(List<CartEntity> cart) async {
    await hiveHelper.saveData<CartEntity>(cart, HiveBoxesNames.kCartBox);
  }

  @override
  Future<void> removeCartItem(num productId) async {
    final cartItems = await getCart();
    final updatedCartItems =
        cartItems.where((item) => item.id != productId).toList();
    await saveCart(updatedCartItems);
  }

  @override
  Future<void> clearCart() async {
    await hiveHelper.clearData<CartEntity>(HiveBoxesNames.kCartBox);
  }
}
