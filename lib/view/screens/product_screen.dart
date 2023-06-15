import 'package:flutter/material.dart';
import 'package:getx_api/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  /// register product controller
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// add search textfields with notifications icon.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            GetBuilder<ProductController>(
              builder: (_) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.products.isEmpty) {
                  return Center(child: Text('No Data'));
                }
                return Expanded(
                    child: RefreshIndicator(
                  onRefresh: () {
                    return controller.refreshProduct();
                  },
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      if (controller.products.length <= index) {
                        return Container();
                      }
                      return SizedBox(
                        width: 120,
                        height: 200,
                        child: Column(
                          children: [
                            Image.network(
                              controller.products[index].image!,
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                            Text(
                              controller.products[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '\$${controller.products[index].price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
