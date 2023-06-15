import 'package:get/get.dart';
import 'package:getx_api/helper.dart';
import 'package:getx_api/models/product_res_model.dart';

class ProductController extends GetxController {
  final Helper _api = Helper();
  bool isLoading = false;
  List<ProductResModel> productResModel = [];

  /// get set productResModel
  List<ProductResModel> get products => productResModel;

  @override
  void onInit() {
    super.onInit();
    getProduct();
  }

  Future refreshProduct() async {
    getProduct();
    return true;
  }

  void getProduct() async {
    try {
      isLoading = true;
      update();

      /// update the UI
      final product = await _api.getProduct();
      if (product.isNotEmpty) {
        productResModel = product;
      }
      isLoading = false;
      update();

      /// update the UI
      print(product);
    } catch (e) {
      isLoading = false;
      update();
      print(e);
    }
  }
}
