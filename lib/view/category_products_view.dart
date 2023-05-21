import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grock/grock.dart';

import '../model/product_model.dart';
import 'product_detail_view.dart';
import 'widgets/custom_text.dart';
import '../constants.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryName;
  final List<ProductModel> products;

  const CategoryProductsView({super.key, required this.categoryName, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 130.h,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText(
                    text: categoryName,
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 24.h),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 320,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        ProductDetailView(products[index]),
                      );
                    },
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 164.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: 15.allBR,
                                color: Colors.white,
                        boxShadow: const [BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                      )],
                              ),
                              height: 220.h,
                              width: 250.w,
                              child: Image.network(
                                products[index].image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            CustomText(
                              text: products[index].name,
                              fontSize: 14,
                            ),
                            CustomText(
                              text: products[index].description,
                              fontSize: 12,
                              color: Colors.grey,
                              maxLines: 1,
                            ),
                            CustomText(
                              text: '\$${products[index].price}',
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
