import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proj3/models/game_page_arguments.dart';
import 'package:proj3/pages/achievements_page.dart';
import 'package:proj3/pages/game_page.dart';
import 'package:proj3/pages/categories_page.dart';
import 'package:proj3/pages/difficulty_page.dart';
import 'package:proj3/pages/help_page.dart';
import 'package:proj3/pages/loading_page.dart';
import 'package:proj3/pages/sign_up_page.dart';
import 'package:proj3/pages/start_page.dart';
import 'package:proj3/pages/story_mode_page.dart';
import 'data/player.dart';
import 'data/profile.dart';
import 'pages/leader_board_page.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var devices = ["E77E18AFD5A5F1A6D3C8F6CCC06C22C9"];
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Player.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  await Hive.openBox('myData');
  if (MyApp.myData.get('sound') == null) MyApp.myData.put('sound', 1);
  if(MyApp.myData.get('sound') == 1) {
    await Player.backgroundPlay();
  }
  if (MyApp.myData.get('userId') != null)
    await ProfileInfo.getData(MyApp.myData.get('userId'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final myData = Hive.box('myData');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => MainPage(),
        '/': (context) => myData.get('userId') == null ? SignUp() : MainPage(),
        '/difficulty': (context) => Difficulty(),
        '/categories-page': (context) => CategoriesPage(),
        '/loading-screen': (context) => LoadingScreen(),
        '/story-mode': (context) => StoryMode(),
        '/achievements': (context) => Achievements(),
        '/leader-board': (context) => LeaderBoard(),
        '/game': (context) => Game(
            arg:
                ModalRoute.of(context)?.settings.arguments as GamePageArgument),
        // '/secondPage': (context) => SecondPage(message: ModalRoute.of(context)?.settings.arguments as String),

        '/sign-in': (context) => SignIn(),
        '/sign-up': (context) => SignUp(),
        '/help': (context) => Help(),
      },
    );
  }
}
