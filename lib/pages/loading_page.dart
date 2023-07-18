import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/pages/start_page.dart';

import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    MainPage.ad.getInterstitialAd()?.show();

    MainPage.ad.initInterstitialAd();

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: MyColors.backgroundColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitSpinningLines(
                  color: MyColors.white,
                  size: 100,
                  lineWidth: 4,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Loading...',
                  style: generateStyle(
                    FontWeight.w500,
                    MyColors.white,
                    MySize.screenText,
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       MainPage.ad.getInterstitialAd()?.show();

                //     MainPage.ad.initInterstitialAd();
                //   },
                //   child: Text('press me right now'),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
