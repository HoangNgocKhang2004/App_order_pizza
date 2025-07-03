import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIncreaseDecrease extends StatefulWidget {
  int quatity = 1;
  CustomIncreaseDecrease({super.key, required quatity});

  @override
  State<CustomIncreaseDecrease> createState() => _CustomIncreaseDecreaseState();
}

class _CustomIncreaseDecreaseState extends State<CustomIncreaseDecrease> {
  int quatity = 1;
  int selectedPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildQuatityControl(
          icon: Icons.remove, 
          onPressed: (){
            setState(() {
              quatity == 1 ? quatity = 1 : quatity--;
            });
          }
        ),
        Text(
          '$quatity',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        buildQuatityControl(
          icon: Icons.add, 
          onPressed: (){
            setState(() {
              quatity == 100 ? quatity = 100 : quatity++;
            });
          }
        ),
      ],
    );
  }

  Widget buildQuatityControl({required IconData icon, required VoidCallback onPressed}){
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        minimumSize: Size(10, 10),
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(width: 1, color: AppColors.border)
        ) 
      ),
      icon: Icon(
        icon,
        size: 16,
        color: AppColors.primary,
      )
    );
  }
}