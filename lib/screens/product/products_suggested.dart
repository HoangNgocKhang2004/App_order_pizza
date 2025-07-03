// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_food_delivery/screens/product/product_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:app_food_delivery/models/product_model.dart';

// ignore: must_be_immutable
class ProductsSuggested extends StatelessWidget {
  // Danh sách sản phẩm gợi ý
  List<ProductModel> products;
  ProductsSuggested({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ProductDetailScreen(
                  productId: products[index].productId,
                )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
              ),
              width: 120,
              margin: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)
                      ),
                      child: Image.asset(
                        "assets/image_product/${products[index].imageUrl}",
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Text(
                      products[index].productName,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 6),
                    child: Text(
                      FormatUtils.formattedPriceDouble(products[index].price) + AppStrings.tienTe,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
