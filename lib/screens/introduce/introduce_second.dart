import 'package:app_food_delivery/app.dart';
import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:app_food_delivery/main.dart';
import 'package:flutter/material.dart';

class IntroduceSecond extends StatefulWidget {
  const IntroduceSecond({super.key});

  @override
  State<IntroduceSecond> createState() => _IntroduceSecondtState();
}

class _IntroduceSecondtState extends State<IntroduceSecond> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainApp()) 
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo2.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover
                          ),

                          SizedBox(height: 10,),

                          Text(
                            "Tiếp lợi thế, nối thành công",
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      )
                    )
                  ),
                  
                Column(
                  children: [ 
                    Text(
                      "Verison 5.6.7",
                      style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                    ),

                    Text(
                      "© 2025 TOPCV.All rights reserved.",
                      style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                    ),

                    SizedBox(height: 20,)
                  ],
                )

              ],
            )
          ],
        )
      )
    );
  }
}