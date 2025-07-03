import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/models/product_model.dart';
import 'package:app_food_delivery/screens/product/product_detail_screen.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:flutter/material.dart';

class CategoriesListProduct extends StatefulWidget {
  final List<ProductModel> products;
  const CategoriesListProduct({
    super.key,
    required this.products,
  });

  @override
  State<CategoriesListProduct> createState() => _CategoriesListProductState();
}

class _CategoriesListProductState extends State<CategoriesListProduct> {

  bool isLike = false;
  void isCheckLike(){
    setState(() {
      if(isLike){
        isLike = false;
      }
      else{
        isLike = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        //itemCount: currentListProduct.length,
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return buildProductItem(context, index);
        },
      ),
    );
  }

  Widget buildProductItem(BuildContext context, int index) {
    return GestureDetector(
      onTap:() {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => ProductDetailScreen(
            productId: widget.products[index].productId,
          )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.background
        ),
        child: Stack(
          children: [
            // Ảnh sản phẩm
            Positioned(
              child: Transform.translate(
                offset: Offset(-82, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)
                    )
                  ),
                  child: Image.asset(
                    "assets/image_product/${widget.products[index].imageUrl}",
                    height: 110,
                    width: 218,
                    fit: BoxFit.fitWidth,
                  ),
                )
              ),
            ),
            // Thông tin sản phẩm
            Positioned(
              left: 136,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(top: 0),
                          child: Text(
                            widget.products[index].productName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 16, top: 2),
                          width: 150,
                          child: Text(
                            widget.products[index].description ?? AppStrings.noDescription,
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.textSecondary
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(top: 0),
                          width: 150,
                          child: Text(
                            FormatUtils.formattedPriceDouble(widget.products[index].price) + AppStrings.tienTe,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),

                  // Like and Add to cart
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // like
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            onTap: (){
                              isCheckLike();
                            },
                            child: Image.asset(
                              "assets/icons/heart.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.fill,
                              color: isLike ? AppColors.heart : AppColors.backgroudGreyBland,
                            ),
                          ),
                        ),
                        // add to cart
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: GestureDetector(
                            onTap: (){

                            },
                            child:  Image.asset(
                              "assets/icons/add_cart.png",
                              width: 24,
                              height: 24,
                              fit: BoxFit.fill,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
