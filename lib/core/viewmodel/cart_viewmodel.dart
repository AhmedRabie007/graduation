import 'package:get/get.dart';

import '../services/local_database_cart.dart';
import '../../model/cart_model.dart';

class CartViewModel extends GetxController {

  List<CartModel> _cartProducts = [];

  List<CartModel> get cartProducts => _cartProducts;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;


  @override
  void onInit() {
    super.onInit();
    getCartProducts();
  }

  getCartProducts() async {
    _cartProducts = await LocalDatabaseCart.db.getAllProducts();
    getTotalPrice();
    update();
  }

  addProduct(CartModel cartModel) async {
    bool isExist = false;
    for (var element in _cartProducts) {
      if (element.productId == cartModel.productId) {
        isExist = true;
      }
    }
    if (!isExist) {
      await LocalDatabaseCart.db.insertProduct(cartModel);
      getCartProducts();
    }
    String successMessage =
    RxStatus.success().toString().substring(RxStatus.success().toString().indexOf(' ') + 1);
    Get.snackbar(
      'Successfully Added',
      successMessage,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  getTotalPrice() {
    _totalPrice = 0.0;
    for (var cartProduct in _cartProducts) {
      _totalPrice += (double.parse(cartProduct.price) * cartProduct.quantity);
    }
  }

  removeProduct(String productId) async {
    await LocalDatabaseCart.db.deleteProduct(productId);
    getCartProducts();
  }

  removeAllProducts() async {
    await LocalDatabaseCart.db.deleteAllProducts();
    getCartProducts();
  }



  increaseQuantity(int index) async {
    _cartProducts[index].quantity++;

    getTotalPrice();
    await LocalDatabaseCart.db.update(_cartProducts[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (_cartProducts[index].quantity != 0) {
      _cartProducts[index].quantity--;
      getTotalPrice();
      await LocalDatabaseCart.db.update(_cartProducts[index]);
      update();
    }
  }
}
