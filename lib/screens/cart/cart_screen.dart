import 'dart:ffi';
import 'package:app_food_delivery/screens/order/order_checkout_screen.dart';
import 'package:app_food_delivery/widgets/custom_timerpicker.dart';
import 'package:intl/intl.dart';
import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/core/constants/app_strings.dart';
import 'package:app_food_delivery/core/utils/format_utils.dart';
import 'package:app_food_delivery/screens/promotion/promotion_list_screen.dart';
import 'package:app_food_delivery/screens/promotion/promotion_screen.dart';
import 'package:app_food_delivery/widgets/custom_increase_decrease.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartList = [
    {
      'id': 1,
      'name': 'Pizza Siêu Topping Hải Sản Xốt Pesto "Chanh Sả"',
      'price': 710000,
      'image': 'assets/images/pizza.png',
      'crust': "Đế Vừa",
      'size': 12,
      'quantity': 2,
    },
    {
      'id': 2,
      'name': 'Burger Phô Mai',
      'price': 190000,
      'image': 'assets/images/pizza.png',
      'crust': "Đế Mỏng",
      'size': 7,
      'quantity': 2,
    },
    {
      'id': 3,
      'name': 'Salad Caesar',
      'price': 980000,
      'image': 'assets/images/pizza.png',
      'crust': "Đế Dày",
      'size': 9,
      'quantity': 2,
    },
    {
      'id': 4,
      'name': 'Mì Ý Carbonara',
      'price': 109099,
      'image': 'assets/images/pizza.png',
      'crust': "Đế Dày",
      'size': 12,
      'quantity': 2,
    },
  ];

  int selectedButton = 1; // Chọn ô promotion mặc định
  int qualityCart = 10;

  // Controller nhập liệu
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _noteOrderController = TextEditingController();

  // Giá trị radio
  String? _selectedDeliMethod = 'Delivery Now'; // Phương thức giao hàng
  String? _selectedPaymentMethod = 'Phương Thức Thanh Toán'; // Phương thức thanh toán
  String? _selectedDeliveryTime; // Thời gian giao hàng

  String crustAndSize(int index) {
    return cartList[index]["crust"] + " Bột Tươi - Cỡ " + cartList[index]["size"].toString() + " inch";
  }

  double totalMoney() {
    double total = 0;
    for (var cartItem in cartList) {
      total += cartItem['price'] * cartItem["quantity"];
    }
    return total;
  }

  // Trạng thái Giao hàng hay mua về
  void onToggleButton(int buttonIndex) {
    setState(() {
      selectedButton = buttonIndex;
    });
  }

  // Hàm hiển thị bottom sheet chọn thời gian giao hàng
  void _showDeliveryTimeBottomSheet(BuildContext context) {
    // Biến tạm để lưu thời gian được chọn trong bottom sheet
    // Đảm bảo tempSelectedTime không bao giờ là null bằng cách cung cấp giá trị mặc định
    TimeOfDay tempSelectedTime = _selectedDeliveryTime != null
        ? TimeOfDay(
            hour: int.parse(_selectedDeliveryTime!.split(":")[0]),
            minute: int.parse(_selectedDeliveryTime!.split(":")[1].split(" ")[0]))
        : TimeOfDay.now();

    // Hàm định dạng thời gian thủ công
    String formatTime(TimeOfDay time) {
      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
  }

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề hiển thị thời gian đã chọn
                Text(
                  'Giao Hàng, Hôm Nay là ${formatTime(tempSelectedTime)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Nút để mở TimePicker
                Expanded(child:Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // color: AppColors.primary
                      color: Colors.white
                    ),
                    child: CustomTimePicker(
                      initialTime: tempSelectedTime,
                      onTimeChanged: (TimeOfDay newTime) {
                        setModalState(() {
                          tempSelectedTime = newTime;
                        });
                      },
                    ),
                  ),
                ),),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    width: 100,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2)
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/pizze_clock.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        color: AppColors.primary
                      ),
                      const SizedBox(width: 10,),
                      const Text(
                        'Chọn giờ giao hàng',
                        style: TextStyle(
                          color:AppColors.primary,
                          fontSize: 16, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ),
                const SizedBox(height: 16),
                // Nút Xác Nhận và Hủy
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Hủy',
                        ),
                      ),
                    ),
                    SizedBox(width:10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedDeliveryTime = formatTime(tempSelectedTime);
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Xác Nhận',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Địa chỉ
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 4),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.border,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Text(
                                selectedButton == 1
                                    ? "36 Ngô Bệ Phường 13, Quận Tân Bình, Thành Phố Hồ Chí Minh"
                                    : "Please Select Store",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
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
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.bounceInOut,
                                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    decoration: BoxDecoration(
                                      color: selectedButton == 1 ? AppColors.buttonPrimary : AppColors.backgroudGreyBland,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "Giao Hàng",
                                      style: TextStyle(
                                        color: selectedButton == 1 ? Colors.white : AppColors.textSecondary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => onToggleButton(0),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                    decoration: BoxDecoration(
                                      color: selectedButton == 0 ? AppColors.buttonPrimary : AppColors.backgroudGreyBland,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "Đến Lấy",
                                      style: TextStyle(
                                        color: selectedButton == 0 ? Colors.white : AppColors.textSecondary,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
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
                  // Danh sách sản phẩm trong giỏ hàng
                  SizedBox(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return buildCartItem(index);
                      },
                    ),
                  ),
                  // Có thể bạn sẽ thích
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 10),
                    child: Text(
                      "Có thể bạn sẽ thích",
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                    height: 140,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return buildYourFavouriteItem(
                          imgPath: "assets/images/pizza.png",
                          name: "Gà Viên Phô Mai Đút Lò",
                          price: 69000,
                          onAddToCart: () {
                            print("Thêm vào giỏ hàng");
                          },
                        );
                      },
                    ),
                  ),
                  // Khám phá với E-voucher
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainApp()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: AppColors.border),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                  color: AppColors.textPrimary.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/pizza.png",
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 6),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Khám Phá Thực Đơn",
                                              style: TextStyle(
                                                color: AppColors.textPrimary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Thêm Nhiều Món Ngon Vào Giỏ Hàng",
                                              style: TextStyle(
                                                color: AppColors.textSecondary,
                                                fontSize: 11,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainApp()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: AppColors.border),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                  color: AppColors.textPrimary.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/discount_tag.png",
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.cover,
                                          color: AppColors.error,
                                        ),
                                        SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "E-voucher",
                                              style: TextStyle(
                                                color: AppColors.textPrimary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                "Áp Dụng E-Voucher Và Xem Thêm Các Ưu Đãi Tuyệt Vời Khác",
                                                softWrap: true,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: AppColors.textSecondary,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Thông tin khách hàng
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: AppColors.border),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(1, 1),
                                color: AppColors.textPrimary.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              buildCustomerTextField(
                                label: "Tên Khách Hàng",
                                isCompulsory: true,
                                prefixIcon: Icons.person,
                                hintText: "Nhập tên của bạn",
                                onChanged: (value) {},
                                controller: _nameController,
                              ),
                              buildCustomerTextField(
                                label: "Email",
                                isCompulsory: true,
                                prefixIcon: Icons.email,
                                hintText: "Nhập email của bạn",
                                onChanged: (value) {},
                                controller: _emailController,
                              ),
                              buildCustomerTextField(
                                label: "Số Điện Thoại",
                                isCompulsory: true,
                                prefixIcon: Icons.phone,
                                hintText: "Nhập số điện thoại của bạn",
                                onChanged: (value) {},
                                controller: _phoneNumberController,
                              ),
                              buildCustomerTextField(
                                label: "Ghi Chú Đơn Hàng",
                                isCompulsory: false,
                                prefixIcon: Icons.edit,
                                hintText: "Nhập ghi chú đơn hàng (nếu có)",
                                onChanged: (value) {},
                                controller: _noteOrderController,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Chọn phương thức giao hàng:',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    // Delivery Now
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      decoration: BoxDecoration(
                                        color: _selectedDeliMethod == 'Delivery Now'
                                            ? AppColors.primary.withOpacity(0.05)
                                            : Colors.grey.shade50,
                                        border: Border.all(
                                          color: _selectedDeliMethod == 'Delivery Now'
                                              ? AppColors.primary
                                              : AppColors.border,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: RadioListTile<String>(
                                        visualDensity: VisualDensity.compact,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                        title: const Text(
                                          'Giao Hàng Tận Nơi - Ngay Bây Giờ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        value: 'Delivery Now',
                                        groupValue: _selectedDeliMethod,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedDeliMethod = value!;
                                            _selectedDeliveryTime = null; // Reset thời gian khi đổi phương thức
                                          });
                                        },
                                        activeColor: AppColors.primary,
                                      ),
                                    ),
                                    // Delivery Time
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedDeliMethod = 'Delivery Time';
                                        });
                                        _showDeliveryTimeBottomSheet(context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 4),
                                        decoration: BoxDecoration(
                                          color: _selectedDeliMethod == 'Delivery Time'
                                              ? AppColors.primary.withOpacity(0.05)
                                              : Colors.grey.shade50,
                                          border: Border.all(
                                            color: _selectedDeliMethod == 'Delivery Time'
                                                ? AppColors.primary
                                                : AppColors.border,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: RadioListTile<String>(
                                          visualDensity: VisualDensity.compact,
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                          title: const Text(
                                            'Giao Hàng Thời Gian - Hẹn Giờ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value: 'Delivery Time',
                                          groupValue: _selectedDeliMethod,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedDeliMethod = value!;
                                            });
                                            _showDeliveryTimeBottomSheet(context);
                                          },
                                          activeColor: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    // Hiển thị thời gian đã chọn (nếu có)
                                    if (_selectedDeliMethod == 'Delivery Time' && _selectedDeliveryTime != null)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16, top: 4, bottom: 16),
                                        child: Text(
                                          'Thời gian giao: $_selectedDeliveryTime',
                                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Phần chọn phương thức thanh toán
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              ExpansionTile(
                                title: SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/payment.png",
                                            width: 28,
                                            height: 28,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            _selectedPaymentMethod ?? 'Phương Thức Thanh Toán',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: _selectedPaymentMethod == null
                                                  ? AppColors.textSecondary
                                                  : AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                backgroundColor: Colors.white,
                                collapsedBackgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(color: AppColors.border, width: 1),
                                ),
                                collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(color: AppColors.border, width: 1),
                                ),
                                children: [
                                  RadioListTile<String>(
                                    visualDensity: VisualDensity.compact,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/payment.png",
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Thanh Toán Tiền Mặt',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    value: 'Thanh Toán Tiền Mặt',
                                    groupValue: _selectedPaymentMethod,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPaymentMethod = value;
                                      });
                                    },
                                    activeColor: AppColors.primary,
                                  ),
                                  RadioListTile<String>(
                                    visualDensity: VisualDensity.compact,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/payment.png",
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Thanh Toán MoMo',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    value: 'Thanh Toán MoMo',
                                    groupValue: _selectedPaymentMethod,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPaymentMethod = value;
                                      });
                                    },
                                    activeColor: AppColors.primary,
                                  ),
                                  RadioListTile<String>(
                                    visualDensity: VisualDensity.compact,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/payment.png",
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Thanh Toán Bank',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    value: 'Thanh Toán Bank',
                                    groupValue: _selectedPaymentMethod,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedPaymentMethod = value;
                                      });
                                    },
                                    activeColor: AppColors.primary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Giảm giá khác
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Giảm Khuyến Mãi",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              "0" + AppStrings.tienTe,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Giảm Voucher",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              "0" + AppStrings.tienTe,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Phí Giao Hàng",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              "0" + AppStrings.tienTe,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 120),
                ],
              ),
            ),
            // Hoàn tất thanh toán
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: AppColors.border,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Tổng cộng: ",
                            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                          Text(
                            FormatUtils.formattedPriceDouble(totalMoney()) + AppStrings.tienTe,
                            style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_nameController.text.trim().isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng điền tên!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          if(_emailController.text.trim().isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng điền email!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          if(_phoneNumberController.text.trim().isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng điền số điện thoại!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          
                          if (_selectedPaymentMethod == null || _selectedPaymentMethod == 'Phương Thức Thanh Toán') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng chọn phương thức thanh toán!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (_selectedDeliMethod == 'Delivery Time' && _selectedDeliveryTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng chọn thời gian giao hàng!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                             //Lấy toàn bộ thông tin của đơn hàng để qua chi tiết đơn hàng
                            // final order = Order(
                            //   customerName: _nameController.text.trim(),
                            //   email: _emailController.text.trim(),
                            //   phoneNumber: _phoneNumberController.text.trim(),
                            //   note: _noteOrderController.text.trim(),
                            //   deliveryMethod: _selectedDeliMethod!,
                            //   deliveryTime: _selectedDeliveryTime,
                            //   paymentMethod: _selectedPaymentMethod!,
                            //   cartItems: cartList,
                            //   totalAmount: totalMoney(),
                            // );

                            // In thông tin đơn hàng trực tiếp test
                            print('=== Thông Tin Đơn Hàng ===');
                            print('Tên khách hàng: ${_nameController.text}');
                            print('Email: ${_emailController.text}');
                            print('Số điện thoại: ${_phoneNumberController.text}');
                            print('Ghi chú: ${_noteOrderController.text.isEmpty ? "Không có" : _noteOrderController.text}');
                            print('Phương thức giao hàng: $_selectedDeliMethod');
                            if (_selectedDeliveryTime != null) {
                              print('Thời gian giao hàng: $_selectedDeliveryTime');
                            }
                            print('Phương thức thanh toán: $_selectedPaymentMethod');
                            print('Danh sách sản phẩm:');
                            for (var item in cartList) {
                              print('  - ${item['name']} (Số lượng: ${item['quantity']}, Giá: ${FormatUtils.formattedPrice(item['price'])} ${AppStrings.tienTe})');
                            }
                            print('Tổng số tiền: ${FormatUtils.formattedPriceDouble(totalMoney())} ${AppStrings.tienTe}');
                            print('=========================');
                            //Chuyển hướng và truyền dữ liệu
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderCheckoutScreen(
                                customerName: _nameController.text,
                                email: _emailController.text,
                                phoneNumber: _phoneNumberController.text,
                                note: _noteOrderController.text,
                                deliveryMethod: _selectedDeliMethod!,
                                deliveryTime: _selectedDeliveryTime,
                                paymentMethod: _selectedPaymentMethod!,
                                cartItems: cartList,
                                totalAmount: totalMoney(),
                              )),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Đặt Hàng",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }

  // Hàm hiển thị dialog chọn phương thức thanh toán
  void _showPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chọn Phương Thức Thanh Toán'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                visualDensity: VisualDensity.compact,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                title: const Text(
                  'Thanh Toán Khi Nhận Hàng',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'Thanh Toán Khi Nhận Hàng',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                  Navigator.pop(context);
                },
                activeColor: AppColors.primary,
              ),
              RadioListTile<String>(
                visualDensity: VisualDensity.compact,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                title: const Text(
                  'Thanh Toán Qua Thẻ',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'Thanh Toán Qua Thẻ',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                  Navigator.pop(context);
                },
                activeColor: AppColors.primary,
              ),
              RadioListTile<String>(
                visualDensity: VisualDensity.compact,
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                title: const Text(
                  'Ví Điện Tử',
                  style: TextStyle(fontSize: 12),
                ),
                value: 'Ví Điện Tử',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                  Navigator.pop(context);
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
          ],
        );
      },
    );
  }

  Widget buildCartItem(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(spreadRadius: 2, blurRadius: 2, offset: Offset(2, 2), color: AppColors.textPrimary.withOpacity(0.2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  cartList[index]["image"],
                  width: 70,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      cartList[index]["name"],
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    crustAndSize(index),
                    style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.normal, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          // Xem chi tiết và xóa
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Text(
                      "Xem chi tiết",
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4, top: 1),
                      child: const Icon(
                        Icons.keyboard_double_arrow_down,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cartList.removeAt(index);
                  });
                },
                child: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Tăng giảm số lượng
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  buildQuantityControl(
                    icon: Icons.remove,
                    onPressed: () {
                      setState(() {
                        cartList[index]["quantity"] == 1
                            ? cartList[index]["quantity"] = 1
                            : cartList[index]["quantity"]--;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${cartList[index]["quantity"]}',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  buildQuantityControl(
                    icon: Icons.add,
                    onPressed: () {
                      setState(() {
                        cartList[index]["quantity"] == 100
                            ? cartList[index]["quantity"] = 100
                            : cartList[index]["quantity"]++;
                      });
                    },
                  ),
                ],
              ),
              Text(
                FormatUtils.formattedPrice(cartList[index]["price"]) + AppStrings.tienTe,
                style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Khuyến mãi nếu có
          Visibility(
            visible: true,
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: -4,
                        top: -12,
                        child: Image.asset(
                          "assets/icons/ticket.png",
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                          color: AppColors.error,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                        ),
                        child: Text(
                          "Mua Theo Chương Trình Khuyến Mãi",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/icons/discount_tag.png",
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuantityControl({required IconData icon, required VoidCallback onPressed}) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(width: 1, color: AppColors.border),
          ),
        ),
        icon: Icon(
          icon,
          size: 16,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget buildYourFavouriteItem({required String imgPath, required String name, required int price, required VoidCallback onAddToCart}) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1),
            color: AppColors.textPrimary.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
            ),
            child: const SizedBox(),
            clipBehavior: Clip.hardEdge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                name,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  FormatUtils.formattedPrice(price) + AppStrings.tienTe,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                GestureDetector(
                  onTap: onAddToCart,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomerTextField({
    required String label,
    required bool isCompulsory,
    required IconData? prefixIcon,
    required String hintText,
    required ValueChanged<String>? onChanged,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4, bottom: 6),
              child: Text(
                isCompulsory ? "*" : "",
                style: TextStyle(fontSize: 12, color: AppColors.error),
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            cursorColor: AppColors.primary,
            cursorHeight: 14,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors.grey,
                      size: 18,
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade500,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}