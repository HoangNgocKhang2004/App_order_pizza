import 'package:app_food_delivery/screens/introduce/introduce_second.dart';
import 'package:flutter/material.dart';

class IntroduceFirst extends StatefulWidget {
  const IntroduceFirst({super.key});

  @override
  State<IntroduceFirst> createState() => _IntroduceFirstState();
}

class _IntroduceFirstState extends State<IntroduceFirst> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IntroduceSecond())
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      home: Scaffold(
        body: SafeArea(
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover
              )
            )
        )
      )
    )  ;
  }
}