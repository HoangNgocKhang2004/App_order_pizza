  import 'package:app_food_delivery/core/constants/app_colors.dart';
  import 'package:app_food_delivery/screens/cart/cart_sub.dart';
  import 'package:app_food_delivery/screens/promotion/e_voucher_screen.dart';
  import 'package:app_food_delivery/screens/promotion/promotion_list_screen.dart';
  import 'package:flutter/material.dart';

  class PromotionScreen extends StatefulWidget {
    const PromotionScreen({super.key});

    @override
    State<PromotionScreen> createState() => _PromotionScreenState();
  }

  class _PromotionScreenState extends State<PromotionScreen> {

    //Promotion - E-voucher
    // 0 - E-voucher, 1 - Promotion
    int selectedButton = 1; //  chọn ô promotion mặc định

    int qualityCart = 10;
    
    //Trạng thái Promotion - E-voucher
    void onToggleButton(int buttonIndex){
      setState(() {
        selectedButton = buttonIndex;
      });
    }
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Container(
          child: Column(
            children: [
               // Button Delivery - Carry Out
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroudGreyBland,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(1, 1),
                        blurRadius: 1,
                        spreadRadius: 1,
                      )
                    ]
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: ()=>onToggleButton(1),
                        child: AnimatedContainer(
                          width: 120,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceInOut, // vào chậm – bật ra nhanh – rồi nảy nhẹ
                          padding: EdgeInsets.fromLTRB(24, 6, 24, 6),
                          decoration: BoxDecoration(
                            color: selectedButton == 1 ? AppColors.buttonPrimary : AppColors.backgroudGreyBland,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Promotion",
                            style: TextStyle(
                              color: selectedButton == 1 ?Colors.white : AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:()=>onToggleButton(0),
                        child: AnimatedContainer(
                          width: 120,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.fromLTRB(24, 6, 24, 6),
                          decoration: BoxDecoration(
                            color: selectedButton == 0 ? AppColors.buttonPrimary : AppColors.backgroudGreyBland,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "E-voucher",
                            style: TextStyle(
                              color: selectedButton == 0 ?Colors.white : AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              //Đường phân cách
              Container(
                height: 1,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.backgroudGreyBland
                ),
              ),

              //Nội dung          
              Flexible(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: selectedButton == 1 ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                      reverse: false,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.background
                        ),
                        child: selectedButton == 1 ? PromotionListScreen() : EVoucherScreen()
                      ),
                    ),

                    //Giỏ hàng
                    if(selectedButton == 1) CartSub()
                  ],
                )
              )
            ],
          ),
        )
        
      );
    }
  }