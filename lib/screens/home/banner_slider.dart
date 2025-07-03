import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
    final PageController _pageController = PageController(viewportFraction: 1.0);
    int _currentPage = 0; // page hiện tại
    Timer? _timer;
     
    final List<String> _bannerImages = [
      "assets/images/banner1.png",
      "assets/images/banner1.png",
      "assets/images/banner1.png",
      "assets/images/banner1.png",
    ];

    @override
    void initState(){
      super.initState();
      startAutoScroll();
    }

    void startAutoScroll() {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) {
        if (_pageController.hasClients) {
          _currentPage = (_currentPage + 1) % _bannerImages.length;
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }

    //Chuyển từ đâu qua cuối
    // @override
    // void didChangeDependencies(){
    //   super.didChangeDependencies();
    //   _pageController.addListener((){ //lắn nghe sự kiện 
    //     if(_pageController.page == 0 && _currentPage == 0){ // nếu trang đầu
    //       Future.delayed(Duration(milliseconds: 300),(){ // chờ 300ms mới về trnag cuối
    //         if(_pageController.hasClients){ // kiểm tra pageController hợp lệ 
    //           _pageController.jumpToPage(_bannerImages.length-1); // nhảy sang trang cuối
    //         }
    //       });
    //     }
    //   });
    // }

    @override
    void dispose(){
      _timer?.cancel(); //hủy bộ đếm thời gian
      _pageController.dispose(); //Giải phóng PageController
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              SizedBox(height: 0,),
              //Banner khuyến mãi
              Container(
                width: double.infinity,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                // height: 300,
                height: 250,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index){
                    setState(() {
                      _currentPage = index;
                    });
                    // if (index == 0) {
                    //   Future.delayed(Duration(milliseconds: 300), () {
                    //     if (_pageController.hasClients && _currentPage == 0) {
                    //       _pageController.jumpToPage(_bannerImages.length - 1);
                    //     }
                    //   });
                    // }
                  },
                  itemCount: _bannerImages.length,
                  itemBuilder: (context, index){
                    return buildBannerItem(index);
                  }
                ),
              ),
            ],
          ),
        ),
        //Dấu chấm
        Positioned(
          bottom: 4,
          left: 0,
          right: 0,
          child: Center(
            child: buildDot(),
          )
        )
      ],
    );
  }

  Widget buildBannerItem(int index){
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.zero,
        child: Image.asset(
          _bannerImages[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildDot(){
    return SmoothPageIndicator(
      controller: _pageController, 
      count: _bannerImages.length,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Colors.redAccent,
        dotColor: Colors.grey.shade400,
      ),
    );
  }
}