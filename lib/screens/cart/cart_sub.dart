import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';

class CartSub extends StatefulWidget {
  const CartSub({super.key});

  @override
  State<CartSub> createState() => _CartSubState();
}

class _CartSubState extends State<CartSub> {
   int qualityCart = 0;
  
  @override
  Widget build(BuildContext context) {
    //Giỏ hàng 
    return Positioned(
      bottom: 20,
      right: 40,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>CartScreen())
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 3,
                  color: AppColors.primary
                )
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 2),
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      AppStrings.tienTe,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              )
            ),

          Positioned(
            bottom: -4,
            right: -26,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        "assets/icons/cart.png",
                        fit: BoxFit.fill,
                        color: AppColors.background,
                      ),
                    ),
                    Positioned(
                      top: -4,
                      right: qualityCart < 10 ? -2 : -8,
                      child: IntrinsicWidth(
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Text(
                            qualityCart >= 100 ? "99+" : "$qualityCart",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: AppColors.background,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                    )
                  ],
                )
              ),
            )
          ],
        ),
      
      )
    );
  }
}