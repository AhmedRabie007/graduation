import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grock/grock.dart';

import '../core/viewmodel/checkout_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';
import 'category_products_view.dart';
import 'product_detail_view.dart';
import 'search_view.dart';
import 'widgets/custom_text.dart';
import '../../constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());

    return Scaffold(
      body: GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) => controller.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: 65.h, bottom: 14.h, right: 16.w, left: 16.w),
                child: Column(
                  children: [
                    Container(
                      height: 49.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(45.r),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('search'),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          Get.to(SearchView(value));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    CarouselSlider(
                        items: const [
                          Image(image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/graduation-530cb.appspot.com/o/google-ads-shopping-campaigns-1-1024x536.jpg?alt=media&token=0161da2d-0556-41b7-b8be-dc91f56277d3'),
                          width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/graduation-530cb.appspot.com/o/Coupon%2BMarketing.jpg?alt=media&token=6ce2e603-2f71-4478-8e8f-c3ccfe031d25'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/graduation-530cb.appspot.com/o/sales-promotion-examples.jpg?alt=media&token=5208b441-2386-426c-aa3c-a591eca0dfd0'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(image:NetworkImage('https://firebasestorage.googleapis.com/v0/b/graduation-530cb.appspot.com/o/im_campaigns.png?alt=media&token=091de2e4-b88b-4e02-921d-571875c074fd'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                        options: CarouselOptions(
                          height: 200,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3,),
                          autoPlayAnimationDuration: const Duration(seconds: 1,),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 1.0,
                        )),
                    SizedBox(
                      height: 19.h,
                    ),
                    const CustomText(
                      text: 'Categories',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 19.h,
                    ),
                    const ListViewCategories(
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Best Selling',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(CategoryProductsView(
                              categoryName: 'Best Selling',
                              products: controller.products,
                            ));
                          },
                          child: const CustomText(
                            text: 'See all',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const ListViewProducts(),
                  ],
                ),
              ),
      ),
    );
  }
}

class ListViewCategories extends StatelessWidget {
  const ListViewCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 90.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(CategoryProductsView(
                  categoryName: controller.categories[index].name,
                  products: controller.products
                      .where((product) =>
                          product.category ==
                          controller.categories[index].name.toLowerCase())
                      .toList(),
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(50.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        color: Colors.white,
                      ),
                      height: 60.h,
                      width: 60.w,
                      child: Padding(
                        padding: EdgeInsets.all(14.h),
                        child: Image.network(
                          controller.categories[index].image,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    text: controller.categories[index].name,
                    fontSize: 12,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 20.w,
            );
          },
        ),
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => SizedBox(
        height: 320.h,

        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  ProductDetailView(controller.products[index]),
                );
              },
              child: SizedBox(
                width: 164.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: 10.allBR,
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                          color: Colors.black26,
                          blurRadius:5,
                        ),
                        ] ,
                      ),
                      height: 200.h,
                      width: 150,
                      child: Image.network(
                        controller.products[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: controller.products[index].description,
                      fontSize: 12,
                      color: Colors.grey,
                      maxLines: 1,
                    ),
                    CustomText(
                      text: '\$${controller.products[index].price}',
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10.w,
            );
          },
        ),
      ),
    );
  }
}
