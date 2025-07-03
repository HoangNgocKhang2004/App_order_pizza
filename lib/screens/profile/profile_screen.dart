import 'package:app_food_delivery/api/auth_service.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int qualityNofication = 90;
  bool isButtonLanguage = false;

  Map<String, dynamic>? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print('Token: $token');
      if (token != null) {
        try {
          final user = await AuthService().getCurrentUser(token);
          print('User: $user');
          setState(() {
            userInfo = user;
            isLoading = false;
          });
        } catch (e) {
          print('Lỗi lấy user: $e');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  //Lây thông tin user từ API
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 46,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: AppColors.backgroudGreyBland),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.none,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.backgroudGreyBland,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Avatar - Login/Register
                          Container(
                            height: 240,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Stack(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/banner1.png",
                                    width: double.infinity,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.primary,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          child: Image.asset(
                                            "assets/images/pizza.png",
                                            width: 66,
                                            height: 66,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          isLoading
                                              ? "Đang tải..."
                                              : (userInfo?['userName'] ??
                                                  "Chưa đăng nhập"),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "Member",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1.4,
                                              height: 14,
                                              margin: EdgeInsets.only(
                                                right: 4,
                                                left: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "0" +
                                                    (isButtonLanguage
                                                        ? " Điểm"
                                                        : " Point"),
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                          16,
                                          6,
                                          16,
                                          6,
                                        ),
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: AppColors.primary,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          color: AppColors.primary.withOpacity(
                                            0.1,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/qr_code.png",
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 4),
                                              child: Text(
                                                "123-345-5668",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: buildControlLogin(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Account Information
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    isButtonLanguage
                                        ? "Tài Khoản Của Tôi"
                                        : "My Account",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                buildControl(
                                  "assets/icons/domino.png",
                                  "Thông Tin Cá Nhân",
                                  "Account Information",
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/rewards.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Rewards",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/address.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isButtonLanguage
                                                      ? "Địa Chỉ"
                                                      : "Address",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/order_history.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isButtonLanguage
                                                      ? "Lịch Sử Đơn Hàng"
                                                      : "Order History",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/heart_border.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isButtonLanguage
                                                      ? "Món Yêu Thích"
                                                      : "Wish List",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //General Information
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, bottom: 8),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    isButtonLanguage
                                        ? "Thông tin chung"
                                        : "General Information",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                      10,
                                      10,
                                      10,
                                      10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/store.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isButtonLanguage
                                                      ? "Danh Sách Cửa Hàng"
                                                      : "Store List",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                      10,
                                      10,
                                      10,
                                      10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/store.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isButtonLanguage
                                                      ? "Tin Tức"
                                                      : "Blog",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                      10,
                                      10,
                                      10,
                                      10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                  right: 4,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/store.png",
                                                  width: 14,
                                                  height: 14,
                                                  fit: BoxFit.fill,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  isButtonLanguage
                                                      ? "Chính Sách"
                                                      : "Policy",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColors.textSecondary,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 20,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    print("Text");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                      10,
                                      10,
                                      10,
                                      10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            isButtonLanguage
                                                ? "Ngôn Ngữ"
                                                : "Language",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: AppColors.primary,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isButtonLanguage = true;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                    10,
                                                    3,
                                                    6,
                                                    3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        isButtonLanguage
                                                            ? AppColors.primary
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "VN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          isButtonLanguage
                                                              ? Colors.white
                                                              : AppColors
                                                                  .primary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isButtonLanguage = false;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                    6,
                                                    3,
                                                    10,
                                                    3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        isButtonLanguage
                                                            ? Colors.white
                                                            : AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "EN",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          isButtonLanguage
                                                              ? AppColors
                                                                  .primary
                                                              : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
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
                            ),
                          ),

                          //Control other
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(color: Colors.white),
                              alignment: Alignment.topLeft,
                              child: Text(
                                isButtonLanguage
                                    ? "Thay Đổi Mật Khẩu"
                                    : "Change Password",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(color: Colors.white),
                              alignment: Alignment.topLeft,
                              child: Text(
                                isButtonLanguage
                                    ? "Xóa Tài Khoản"
                                    : "Delete Account",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AuthScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(color: Colors.white),
                              alignment: Alignment.topLeft,
                              child: Text(
                                isButtonLanguage ? "Đăng Xuất" : "Log Out",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),

                          //Contact Information
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/domino.png",
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.fill,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          AppStrings.appName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                buildSeparate(),

                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 16, 40, 16),
                                  child: Text(
                                    isButtonLanguage
                                        ? AppStrings.addressVN
                                        : AppStrings.addressEN,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),

                                buildSeparate(),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          40,
                                          16,
                                          40,
                                          6,
                                        ),
                                        child: Text(
                                          isButtonLanguage
                                              ? "Miễn phí giao hàng"
                                              : "Free Deivery",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: Image.asset(
                                                "assets/icons/phone.png",
                                                width: 22,
                                                height: 22,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: Image.asset(
                                                "assets/icons/browser.png",
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/smartphone.png",
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                buildSeparate(),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          40,
                                          16,
                                          40,
                                          6,
                                        ),
                                        child: const Text(
                                          "Hotline CSKH",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: const Text(
                                          "1410-2004",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                buildSeparate(),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          40,
                                          16,
                                          40,
                                          6,
                                        ),
                                        child: Text(
                                          isButtonLanguage
                                              ? "Kết Nối Với " +
                                                  AppStrings.appName
                                              : "Contact " + AppStrings.appName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/social _facebook.png",
                                                  width: 22,
                                                  height: 22,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/social _instagram.png",
                                                  width: 22,
                                                  height: 22,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/social _tiktok.png",
                                                  width: 22,
                                                  height: 22,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                child: Image.asset(
                                                  "assets/icons/social_youtube.png",
                                                  width: 22,
                                                  height: 22,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                    print("Quay lại trang trước");
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 24, left: 8),
                    child: Icon(Icons.chevron_left),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text(
                    isButtonLanguage ? "Tài Khoản" : "Account",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 24, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      print("Quay lại trang trước");
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          child: Image.asset(
                            "assets/icons/bell.png",
                            width: 21,
                            fit: BoxFit.fill,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Positioned(
                          top: -4,
                          right: qualityNofication < 10 ? -2 : -8,
                          child: IntrinsicWidth(
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                qualityNofication >= 100
                                    ? "99+"
                                    : "$qualityNofication",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.background,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Opacity(
                //   opacity: 0.0,
                //   child: Container(child: Icon(Icons.chevron_left)),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSeparate() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 2,
      decoration: BoxDecoration(color: AppColors.backgroudGreyBland),
    );
  }

  Widget buildControlLogin() {
    return Container(
      width: 130,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(width: 1.4, color: AppColors.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: GestureDetector(
        onTap: () {
          print("test");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                isButtonLanguage ? "Đăng nhập" : "Login",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 1.4,
              height: 14,
              margin: EdgeInsets.only(right: 4, left: 4),
              decoration: BoxDecoration(color: AppColors.primary),
            ),
            Container(
              child: Text(
                isButtonLanguage ? "Đăng ký" : "Register",
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildControl(String icon, String nameControlEn, String nameControlVn) {
    return GestureDetector(
      onTap: () {
        print("Text");
      },
      child: Container(
        padding: EdgeInsets.all(10),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Image.asset(
                      icon,
                      width: 14,
                      height: 14,
                      fit: BoxFit.fill,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      isButtonLanguage ? nameControlVn : nameControlEn,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
