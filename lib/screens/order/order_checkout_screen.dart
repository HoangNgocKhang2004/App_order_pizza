import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:app_food_delivery/screens/feedback/feedback_screen.dart';
import 'package:flutter/material.dart';

class OrderCheckoutScreen extends StatelessWidget {
  final String customerName;
  final String email;
  final String phoneNumber;
  final String note;
  final String deliveryMethod;
  final String? deliveryTime;
  final String paymentMethod;
  final List<Map<String, dynamic>> cartItems;
  final double totalAmount;

  const OrderCheckoutScreen({
    super.key,
    required this.customerName,
    required this.email,
    required this.phoneNumber,
    required this.note,
    required this.deliveryMethod,
    this.deliveryTime,
    required this.paymentMethod,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/pizza_delivery.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                _buildSectionTitle('Cảm Ơn Bạn\n Đã Lựa Chọn ${AppStrings.appName}', true),
                
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: AppColors.border)
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Thông Tin Đơn Hàng",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Text(
                              "Giao Ngay",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Thông tin khách hàng
                      _buildInfoRow('Mã Số Đơn Hàng Của Bạn:', customerName),
                      _buildInfoRow('Tên:', customerName),
                      _buildInfoRow('Email:', email),
                      _buildInfoRow('Số điện thoại:', phoneNumber),
                      _buildInfoRow('Ghi chú:', note.isEmpty ? "Không có" : note),
                      _buildInfoRow('Giao Hàng:', deliveryMethod),
                      if (deliveryTime != null)
                        _buildInfoRow('Thời gian giao:', deliveryTime!),
                      _buildInfoRow('Phương thức:', paymentMethod),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng cộng:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '${FormatUtils.formattedPriceDouble(totalAmount)} ${AppStrings.tienTe}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: AppColors.border)
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Thông tin liên hệ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Text(
                              "19006099",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Text(
                              'Nếu Quý khách có bất kỳ câu hỏi nào hoặc cần hỗ trợ thêm, xin vui lòng liên hệ với chúng tôi qua email support@appfooddelivery.com hoặc số hotline 1900-1234. Chúng tôi luôn sẵn sàng hỗ trợ Quý khách 24/7.\n\n'
                              'Trân trọng,\n'
                              'Đội ngũ ${AppStrings.appName}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                height: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                const SizedBox(height: 160),
                
              ],
            ),
          ),

          //Control ở bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
                border: const Border(
                  top: BorderSide(
                    width: 1,
                    color: AppColors.border,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nút "Theo Dõi Đơn Hàng"
                  ElevatedButton(
                    onPressed: () {
                      // Logic để theo dõi đơn hàng (ví dụ: điều hướng đến màn hình theo dõi)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Chuyển đến màn hình Theo Dõi Đơn Hàng...'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 5,
                      shadowColor: AppColors.primary.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.room_service, size: 18, color: Colors.white,),
                        SizedBox(width: 8),
                        Text(
                          'Theo Dõi Đơn Hàng',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                  // Nút "Đánh Giá Đơn Hàng"
                  ElevatedButton(
                    onPressed: () {
                      // Logic để đánh giá đơn hàng (ví dụ: điều hướng đến màn hình đánh giá)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>FeedbackScreen())
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Chuyển đến màn hình Đánh Giá Đơn Hàng...'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.star, size: 18, color: AppColors.warning),
                        SizedBox(width: 8),
                        Text(
                          'Đánh Giá Đơn Hàng',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                 
                  // Nút "Quay Lại Menu"
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>MainApp())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                      elevation: 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/pizza.png",
                          width: 18,
                          height: 18,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Quay Lại Menu',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  // Widget để hiển thị tiêu đề của mỗi phần
  Widget _buildSectionTitle(String title, bool isColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isColor ? AppColors.primary : AppColors.textPrimary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Widget để hiển thị một dòng thông tin (label: value)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}