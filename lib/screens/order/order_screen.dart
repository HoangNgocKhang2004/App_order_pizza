import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order'; // Định nghĩa routeName

  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int quantityCart = 0; 

  //Lấy danh sách đơn dàng đã từng đặt qua API
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Nội dung chính
        Positioned.fill(
          top: 46,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: AppColors.backgroudGreyBland),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.none,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: AppColors.backgroudGreyBland,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Thông tin số điện thoại
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: const BoxDecoration(color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Đơn Hàng Của Số Điện Thoại",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "0345088996",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Logic để thay đổi số điện thoại (có thể điều hướng đến màn hình nhập số mới)
                                    print("Thay đổi số điện thoại");
                                  },
                                  child: Text(
                                    "Thay Đổi",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Hiển thị thông báo không có đơn hàng
                          quantityCart == 0 ? buildNoCart() : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Header
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1, color: AppColors.border),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Quay lại màn hình trước đó
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 24, left: 16),
                    child: const Icon(
                      Icons.chevron_left,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: const Text(
                    "Theo Dõi Đơn Hàng",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Placeholder để cân đối layout
                const Opacity(
                  opacity: 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24, right: 16),
                    child: Icon(Icons.chevron_left, size: 28),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSeparate() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 2,
      decoration: BoxDecoration(color: AppColors.backgroudGreyBland),
    );
  }

  Widget buildNoCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/no_cart.png",
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        Text(
          "Bạn Hiện Chưa Có Đơn Hàng Nào!",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: TextButton(
            onPressed: () {
              // Điều hướng đến MainApp, tab Menu (chỉ số 2)
              Navigator.pushNamedAndRemoveUntil(
                context,
                MainApp.routeName,
                (Route<dynamic> route) => false,
                arguments: 2, // Tab Menu
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.buttonPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: const Text(
              "Đặt Hàng Ngay",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}