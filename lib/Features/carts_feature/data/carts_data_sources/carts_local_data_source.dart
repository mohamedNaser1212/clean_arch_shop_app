import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

abstract class CartLocalDataSource {
  const CartLocalDataSource();

  Future<List<AddToCartEntity>> getCart();
  Future<void> saveCart(List<AddToCartEntity> cart);
  Future<void> removeCartItem(num productId);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final HiveHelper hiveHelper;

  const CartLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<List<AddToCartEntity>> getCart() async {
    return await hiveHelper.loadData<AddToCartEntity>(HiveBoxesNames.kCartBox);
  }

  @override
  Future<void> saveCart(List<AddToCartEntity> cart) async {
    await hiveHelper.saveData<AddToCartEntity>(cart, HiveBoxesNames.kCartBox);
  }

  @override
  Future<void> removeCartItem(num productId) async {
    final cartItems = await getCart();
    final updatedCartItems =
        cartItems.where((item) => item.id != productId).toList();
    await saveCart(updatedCartItems);
  }
}
