import '../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

abstract class CartLocalDataSource {
  const CartLocalDataSource();
  Future<List<AddToCartEntity>> getCart();
  Future<void> saveCart(List<AddToCartEntity> cart);
  Future<void> removeCart(num productId);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final HiveHelper hiveService;

  const CartLocalDataSourceImpl({required this.hiveService});

  @override
  Future<List<AddToCartEntity>> getCart() async {
    return await hiveService.loadData<AddToCartEntity>(HiveBoxesNames.kCartBox);
  }

  @override
  Future<void> saveCart(List<AddToCartEntity> cart) async {
    await hiveService.saveData<AddToCartEntity>(cart, HiveBoxesNames.kCartBox);
  }

  @override
  Future<void> removeCart(num productId) async {
    final cart = await getCart();
    final updatedCart = cart.where((item) => item.id != productId).toList();
    await saveCart(updatedCart);
  }
}
