import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/text_sizes.dart';
import 'package:proj3/functions/generate_font_style.dart';
import 'package:proj3/widgets/page_temp.dart';

import '../data/player.dart';
import '../data/profile.dart';
import '../main.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isClicked = false;
  bool isLoading = false;
  String? nickNameValidator(String? nickName) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$');
    if (nickName == null || nickName.isEmpty) {
      return 'nickname couldn\'t be empty';
    } else if (emailRegex.hasMatch(nickName + '@fakeExample.com')) {
      return null;
    }
    return 'nickname is invalid';
  }

  String? passwordValidator(String? pass) {
    if (pass == null || pass.isEmpty) {
      return 'password couldn\'t be empty';
    } else if (pass.length < 6) {
      return 'password length should be at least 6';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'Sign in',
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
                  top: 10,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 0,
                  bottom: 90,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 110,
                color: MyColors.backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/main.png',
                      width: MediaQuery.of(context).size.width - 80,
                    ),
                    Text(
                      'Welcome back!',
                      style: generateStyle(
                        FontWeight.w700,
                        MyColors.white,
                        30,
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
                          //password
                          TextFormField(
                            controller: _passwordController,
                            validator: passwordValidator,
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
                                            .signInWithEmailAndPassword(
                                                email:
                                                    _nickNameController.text +
                                                        '@fakeExample.com',
                                                password:
                                                    _passwordController.text);

                                        //get the data from firebase
                                        await ProfileInfo.getData(
                                            _nickNameController.text);
                                        //store the userId in local storage
                                        await MyApp.myData.put(
                                            'userId', _nickNameController.text);
                                        Navigator.pushReplacementNamed(
                                            context, '/');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Signed in successfully!'),
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        String error = 'Error';
                                        if (e.code.toString() ==
                                            'wrong-password') {
                                          error =
                                              'Wrong password! Try again please';
                                        } else if (e.code.toString() ==
                                            'too-many-requests')
                                          error =
                                              'Too many wrong attempts! Please try again later';
                                        // error = e.code.toString();
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
                              width: 300,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: MyColors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Sign in',
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
                          'Not a member? ',
                          style: generateStyle(
                            FontWeight.w500,
                            MyColors.white,
                            MySize.alertText,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await Player.tabPlay();
                            Navigator.pushReplacementNamed(context, '/sign-up');
                          },
                          child: Text(
                            'Sign up!',
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
