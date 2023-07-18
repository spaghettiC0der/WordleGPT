import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj3/data/avatars.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/text_sizes.dart';
import 'package:proj3/functions/generate_font_style.dart';
import 'package:proj3/widgets/page_temp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/player.dart';
import '../data/profile.dart';
import '../main.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  int activeIndex = 4;
  bool isClicked = false;
  bool isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

  String? nickNameValidator(String? nickName) {
    print(nickName!.length);
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$');
    if (nickName == null || nickName.isEmpty) {
      return 'nickname couldn\'t be empty';
    } else if (nickName.length > 10) {
      return 'nickname maximum length is 10';
    } else if (emailRegex.hasMatch(nickName + '@fakeExample.com')) {
      return null;
    }
    return 'nickname is invalid';
  }

  String? passwordValidator1(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'password couldn\'t be empty';
    } else if (pass.length < 6) {
      return 'password length should be at least 6';
    }
    return null;
  }

  String? passwordValidator2(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'password couldn\'t be empty';
    } else if (pass != _passwordController1.text) {
      return 'password doesn\'t match';
    } else if (pass.length < 6) {
      return 'password length should be at least 6';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'Sign-up',
      backButton: false,
      list: [
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: MyColors.backgroundColor,
                ),
              )
            : Container(
                margin: EdgeInsets.only(
                  top: 0,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 0,
                  bottom: 90,
                ),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height - 50,
                // height: double.maxFinite,
                color: MyColors.backgroundColor,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Image.asset(
                    //   'images/main.png',
                    //   width: MediaQuery.of(context).size.width - 80,
                    // ),
                    Container(
                      width: 267,
                      child: Text(
                        'Pick an avatar and a nickname!',
                        textAlign: TextAlign.center,
                        style: generateStyle(
                          FontWeight.w700,
                          MyColors.white,
                          30,
                        ),
                      ),
                    ),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 150,
                        enlargeCenterPage: true,
                        viewportFraction: 0.4,
                        initialPage: 4,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                      ),
                      itemCount: avatars.length,
                      itemBuilder: (context, index, realIndex) {
                        return avatars[index];
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: avatars.length,
                        effect: JumpingDotEffect(
                          activeDotColor: MyColors.gold,
                        ),
                      ),
                    ),
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          //nickname
                          TextFormField(
                            controller: _nickNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 20,
                              ),
                              hintText: 'Enter your nickname',
                              filled: true,
                              fillColor: MyColors.blanckBox,
                              hintStyle: generateStyle(
                                FontWeight.w100,
                                MyColors.whiteTrans,
                                MySize.labelHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: generateStyle(
                              FontWeight.w500,
                              MyColors.white,
                              MySize.screenText,
                            ),
                            validator: nickNameValidator,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //password1
                          TextFormField(
                            controller: _passwordController1,
                            validator: passwordValidator1,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 20,
                              ),
                              hintText: 'Enter your password',
                              filled: true,
                              fillColor: MyColors.blanckBox,
                              hintStyle: generateStyle(
                                FontWeight.w100,
                                MyColors.whiteTrans,
                                MySize.labelHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: generateStyle(
                              FontWeight.w500,
                              MyColors.white,
                              MySize.screenText,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //password2
                          TextFormField(
                            controller: _passwordController2,
                            validator: passwordValidator2,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 20,
                              ),
                              hintText: 'Re-enter your password',
                              filled: true,
                              fillColor: MyColors.blanckBox,
                              hintStyle: generateStyle(
                                FontWeight.w100,
                                MyColors.whiteTrans,
                                MySize.labelHint,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: generateStyle(
                              FontWeight.w500,
                              MyColors.white,
                              MySize.screenText,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: isClicked
                                ? () {}
                                : () async {
                                    Player.tabPlay();
                                    if (_key.currentState!.validate()) {
                                      setState(() {
                                        isClicked = true;
                                        isLoading = true;
                                      });
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email:
                                                    _nickNameController.text +
                                                        '@fakeexample.com',
                                                password:
                                                    _passwordController1.text);

                                        //create database
                                        ProfileInfo.setData(
                                          id: _nickNameController.text,
                                          avatar: activeIndex,
                                        );
                                        //save in memory
                                        MyApp.myData.put(
                                            'userId', _nickNameController.text);
                                        Navigator.pushReplacementNamed(
                                            context, '/');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Signed up successfully!'),
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        String error = 'Error';
                                        if (e.code == 'email-already-in-use') {
                                          error =
                                              'this nickname is already taken';
                                        }
                                        error = e.code;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(error),
                                          ),
                                        );
                                        setState(() {
                                          isClicked = false;
                                          isLoading = false;
                                        });
                                      }
                                    }
                                  },
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom: 30,
                              ),
                              width: 300,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Sign up',
                                style: generateStyle(FontWeight.w500,
                                    MyColors.white, MySize.screenText),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already registered? ',
                          style: generateStyle(
                            FontWeight.w500,
                            MyColors.white,
                            MySize.alertText,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Player.tabPlay();
                            Navigator.pushReplacementNamed(context, '/sign-in');
                          },
                          child: Text(
                            'Sign in!',
                            style: generateStyle(
                              FontWeight.w700,
                              Color.fromARGB(255, 192, 26, 131),
                              MySize.alertText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
