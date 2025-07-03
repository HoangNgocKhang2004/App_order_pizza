import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_icons.dart';
import 'package:app_food_delivery/core/constants/app_padding.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/screens/feedback/feedback_thankyou_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  static const routeName = '/feedback';
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Map lưu số sao cho từng tiêu chí
  Map<String, int> ratings = {
    '1. Đế bánh (Crust)': 0,
    '2. Nước sốt (Sauce)': 0,
    '3. Phô mai (Cheese)': 0,
    '4. Topping (Nguyên liệu phủ bên trên)': 0,
    '5. Hương vị tổng thể': 0,
    '6. Trình bày (Presentation)': 0,
    '7. Dịch vụ và trải nghiệm': 0,
  };
  final TextEditingController _commentController = TextEditingController();

  void _submitReview() {
    // Kiểm tra nếu có tiêu chí nào chưa được đánh giá
    if (ratings.values.any((rating) => rating == 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đánh giá tất cả các tiêu chí!')),
      );
      return;
    }
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập bình luận!')),
      );
      return;
    }

    // In dữ liệu (có thể thay bằng lưu vào database/API)
    print('Đánh giá: $ratings');
    print('Bình luận: $comment');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đánh giá đã được gửi thành công!')),
    );

    // Reset đánh giá về 0
    setState(() {
      ratings.updateAll((key, value) => 0);
      _commentController.clear();
    });

    showCustomDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Tiêu đề
            Container(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=> MainApp())
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      child: Icon(
                        Icons.close,
                        size: 22,
                      )
                    ),
                  ),
              
                  const Text(
                    'Đánh Giá Đơn Hàng',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.rate_review, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Filter
            Expanded(
              child: SingleChildScrollView(
                padding: AppPadding.paddingLe,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    //Chi tiết đơn hàng
                    buildOrderDetailsCard(),
                    const SizedBox(height: 24),

                    // Bảng đánh giá chất lượng
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primary.withOpacity(0.1), Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Bảng đáng giá chất lượng",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: ratings.keys.map((criterion) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  criterion,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: List.generate(5, (index) {
                                    return IconButton(
                                      icon: Icon(
                                        index < ratings[criterion]!
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        print(index+1);
                                        setState(() {
                                          ratings[criterion] = index + 1;
                                        });
                                      },
                                      padding: EdgeInsets.zero,
                                      splashRadius: 20,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Ô bình luận
                    const Text(
                      'Bình luận',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.border,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _commentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Cho chúng tôi biết về trải nghiệm của bạn',
                          hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Nút thêm ảnh và video
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Logic thêm ảnh
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.photo, color: AppColors.primary, size: 20),
                                const SizedBox(width: 8),
                                const Text(
                                  'Thêm ảnh',
                                  style: TextStyle(color: AppColors.primary, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Logic thêm video
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.video_call, color: AppColors.primary, size: 20),
                                const SizedBox(width: 8),
                                const Text(
                                  'Thêm video',
                                  style: TextStyle(color: AppColors.primary, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Nút gửi đánh giá
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submitReview,
                        icon: const Icon(Icons.send, size: 20, color: Colors.white,),
                        label: const Text(
                          'Gửi Đánh Giá',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
  Widget buildOrderDetailsCard() {
    // Dữ liệu mẫu danh sách món (có thể thay bằng dữ liệu thực tế)
    //Lấy chi tiết đơn hàng từ API

    final List<Map<String, dynamic>> orderItems = [
      {
        'image': 'assets/images/pizza.png',
        'name': 'Pizza Hải Sản',
        'price': '225.000đ',
        'size': 'L',
        'crust': 'Dày',
      },
      {
        'image': 'assets/images/pizza.png',
        'name': 'Pizza Phô Mai',
        'price': '180.000đ',
        'size': 'M',
        'crust': 'Vừa',
      },
      {
        'image': 'assets/images/pizza.png',
        'name': 'Pizza Bò Nướng',
        'price': '250.000đ',
        'size': 'XL',
        'crust': 'Mỏng',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list_alt, size: 22,),
              SizedBox(width: 8),
              Container(
                child: const Text(
                'Chi Tiết Đơn Hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true, // Đảm bảo ListView không chiếm toàn bộ không gian
            physics: const NeverScrollableScrollPhysics(), // Tắt cuộn riêng để dùng cuộn của SingleChildScrollView
            itemCount: orderItems.length,
            itemBuilder: (context, index) {
              final item = orderItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        AppIcons.icons[index],
                        size: 22,
                      )
                    ),
                    SizedBox(width: 8),
                    // Ảnh món
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        item['image'],
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Thông tin món
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Size: ${item['size']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                ' - ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'Đế: ${item['crust']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Giá: ${item['price']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: AppColors.border
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                'Thời gian đặt: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '04/04/2025, 10:30',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Tổng tiền: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '300.000' + AppStrings.tienTe,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Cho phép đóng khi nhấn ra ngoài
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent, // Để dùng gradient custom
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Giữ kích thước nhỏ gọn
            children: [
              // Tiêu đề
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withOpacity(0.2), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Xác Nhận Gửi Đánh Giá',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nội dung
              const Text(
                'Bạn có chắc chắn muốn gửi đánh giá này không?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              // Nút hành động
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Nút Hủy
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: AppColors.textPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Hủy',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Nút Xác nhận
                  ElevatedButton(
                    onPressed: () {
                      // Logic gửi đánh giá ở đây
                      print('Đánh giá đã được gửi!');
                      Navigator.of(context).pop(); // Đóng dialog
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => FeedbackThankyouScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 4,
                      shadowColor: AppColors.primary.withOpacity(0.5),
                    ),
                    child: const Text(
                      'Gửi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
}

