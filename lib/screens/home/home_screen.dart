import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:app_food_delivery/screens/feedback/feedback_screen.dart';
import 'package:app_food_delivery/screens/home/banner_slider.dart';
import 'package:app_food_delivery/screens/product/product_detail_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLogin = false;
  int selectedButton = 1; // không có nút nào được chọn
  //Trạng thái Delivery - Carryout
  void onToggleButton(int buttonIndex) {
    setState(() {
      selectedButton = buttonIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(0),
      physics: AlwaysScrollableScrollPhysics(),
      reverse: true,
      //controller: ,
      child: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Banner slide
            BannerSlider(),

            //Xinh chào
            Container(
              margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
              alignment: Alignment.center,
              child: const Text(
                "${AppStrings.appName} Say Hello!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            //Order now
            Container(
              height: 131,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.white,),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    top: 14,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 1, color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // Màu bóng
                            spreadRadius: -4, // Độ lan của bóng
                            blurRadius: 4, // Độ mờ của bóng
                            offset: Offset(0, 4), // Độ dịch chuyển (chỉ xuống dưới)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            alignment: Alignment.center,
                            child: const Text(
                              "${AppStrings.appName} Will Recomemend The Nearest Store",
                              style: TextStyle(
                                fontSize: 8,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              print("tets");
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 6),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 1),
                                    child: FaIcon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      size: 12,
                                      color: AppColors.primary,
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: const Text(
                                      "Find Your Nearset Store",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColors.primary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: 32,
                            margin: EdgeInsets.fromLTRB(10, 8, 10, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  MainApp.routeName,
                                  (Route<dynamic> route) => false,
                                  arguments: 2, // Tab Menu
                                );
                              },
                              child: Text(
                                "ORDER NOW".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Button Delivery - Carry Out
                  Positioned(
                    left: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroudGreyBland,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(1, 1),
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => onToggleButton(1),
                            child: AnimatedContainer(
                              width: 101,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.bounceInOut, // vào chậm – bật ra nhanh – rồi nảy nhẹ
                              padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                              decoration: BoxDecoration(
                                color:
                                    selectedButton == 1
                                        ? AppColors.buttonPrimary
                                        : AppColors.backgroudGreyBland,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Delivery",
                                style: TextStyle(
                                  color:
                                      selectedButton == 1
                                          ? Colors.white
                                          : AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => onToggleButton(0),
                            child: AnimatedContainer(
                              width: 101,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                              decoration: BoxDecoration(
                                color:
                                    selectedButton == 0
                                        ? AppColors.buttonPrimary
                                        : AppColors.backgroudGreyBland,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Carry Out",
                                style: TextStyle(
                                  color:
                                      selectedButton == 0
                                          ? Colors.white
                                          : AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Button phụ
            Container(
              width: double.infinity,
              height: 38,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 16),
              decoration: BoxDecoration(
                 boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Màu bóng
                    spreadRadius: -4, // Độ lan của bóng
                    blurRadius: 4, // Độ mờ của bóng
                    offset: Offset(0, 4), // Độ dịch chuyển (chỉ xuống dưới)
                  ),
                ],
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.border, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                        context,
                    MaterialPageRoute(builder: (context) => FeedbackScreen()),
                  );
                },
                child: Text(
                  isLogin
                      ? "BUY 1 GET 1 FREE THURSDAY".toUpperCase()
                      : "Đặt Lại Đơn Gần Nhất",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            //Best seller
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: AppColors.backgroudGreyBland),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: const Text(
                                  "Best seller",
                                  style: TextStyle(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                width: 56,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(0),
                                child: const Text(
                                  "See more",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 1, left: 4),
                                child: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  size: 18,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(margin: EdgeInsets.all(0), child: buildBestSeller()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBestSeller() {
    //Danh sách best seller
    List<String> name = [
      "Seafood Four Seasons",
      "American Cheeseburger",
      "Cheesy Madness",
      "Super Topping Surf And Turf"
    ];
    List<int> price = [
      325000, 205000, 175000, 235000,
    ];
    return  Container(
      height: 184,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: name.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => ProductDetailScreen()),
              // );
            },
            onDoubleTap: (){
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => ProductDetailScreen()),
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6)
              ),
              width: 120,
              margin: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)
                      ),
                      child: Image.asset(
                        "assets/images/pizza.png",
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      name[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 6),
                    child: Text(
                      FormatUtils.formattedPrice(price[index]) + AppStrings.tienTe,
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
