import 'package:app_food_delivery/app.dart';
import 'package:flutter/material.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';

class FeedbackThankyouScreen extends StatefulWidget {
  const FeedbackThankyouScreen({super.key});

  @override
  State<FeedbackThankyouScreen> createState() => _FeedbackThankyouScreenState();
}

class _FeedbackThankyouScreenState extends State<FeedbackThankyouScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;
  late Animation<int> _textAnimation;
  bool _isProgressDone = false; // Trạng thái để kiểm soát hiển thị

  final String thankYouText = 'Cảm ơn bạn đã đánh giá! ❤️';

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000), // Tổng thời gian animation
      vsync: this,
    );

    // Animation cho phóng to hình ảnh
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)),
    );

    // Animation cho fade hình ảnh
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeIn)),
    );

    // Animation cho thanh tiến trình
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    // Animation cho chữ chạy từ từ
    _textAnimation = IntTween(begin: 0, end: thankYouText.length).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeIn)),
    );

    // Theo dõi khi animation hoàn tất
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isProgressDone = true; // Cập nhật trạng thái khi animation xong
        });
      }
    });

    // Chạy animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hình ảnh với animation
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  "assets/images/thankyou_feedback.png",
                  width: 220,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Văn bản chạy từ từ
            AnimatedBuilder(
              animation: _textAnimation,
              builder: (context, child) {
                String displayedText = thankYouText.substring(0, _textAnimation.value);
                return Text(
                  displayedText,
                  textAlign: TextAlign.center, // Canh giữa
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Hiển thị thanh tiến trình hoặc nút dựa trên trạng thái
            _isProgressDone
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context)=> MainApp())
                      ); // Quay về màn trước
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Quay Về',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: _progressAnimation.value,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(10),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(home: FeedbackThankyouScreen()));
}