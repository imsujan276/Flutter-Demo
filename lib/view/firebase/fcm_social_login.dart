import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterbeginner/global/constant/assets_const.dart';
import 'package:flutterbeginner/global/constant/color_const.dart';
import 'package:flutterbeginner/global/utils/random_widget.dart';
import 'package:flutterbeginner/global/utils/social_login_helper.dart';
import 'package:flutterbeginner/global/utils/widget_helper.dart';
import 'package:flutterbeginner/view/firebase/fcm_home.dart';
import 'package:flutterbeginner/view/firebase/fcm_login.dart';
import 'package:flutterbeginner/view/firebase/fcm_login_mobile.dart';
import 'package:flutterbeginner/view/firebase/fcm_signup.dart';

class FcmSocialLogin extends StatefulWidget {
  @override
  _FcmSocialLoginState createState() => _FcmSocialLoginState();
}

class _FcmSocialLoginState extends State<FcmSocialLogin> {
  BuildContext _ctx;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (_context) => _createUi(_context)),
    );
  }

  Widget _createUi(BuildContext context) {
    _ctx = context;
    return Container(
        child: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        bgDesign(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 22),
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(height: 50),
                Center(child: loadCircleImg('imgUrl', 0, 150)),
                SizedBox(height: 80),
                _loginButton('Google', ColorConst.GOOGLE_COLOR,
                    AssetsConst.GOOGLE_IMG, 0),
                SizedBox(height: 10),
                _loginButton(
                    'Facebook', ColorConst.FB_COLOR, AssetsConst.FB_IMG, 1),
                SizedBox(height: 10),
                _loginButton('Twitter', ColorConst.TWITTER_COLOR,
                    AssetsConst.TWITTER_IMG, 2),
                SizedBox(height: 10),
                RaisedButton(
                  color: ColorConst.FCM_APP_COLOR,
                  child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: getTxtWhiteColor(
                          'Phone Number', 15, FontWeight.bold)),
                  onPressed: () => _loginType(3),
                ),
                SizedBox(height: 30),
                Center(child: getTxtGreyColor('or', 17, FontWeight.bold)),
                SizedBox(height: 5),
                Divider(
                  color: Colors.grey,
                  height: 1,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _mannualLoginBtn('Login', 4, false),
                    SizedBox(width: 10),
                    _mannualLoginBtn('Signup', 5, false),
                  ],
                ),
//              SizedBox(height: 20),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _loginButton(String txt, Color btnColor, String image, int loginType) {
    return RaisedButton(
      color: btnColor,
      child: Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loadLocalCircleImg(image, 20),
            SizedBox(width: 20),
            getTxtWhiteColor(txt, 15, FontWeight.bold)
          ],
        ),
      ),
      onPressed: () => _loginType(loginType),
    );
  }

  Widget _mannualLoginBtn(String txt, int loginType, bool isFullWidth) {
    return ButtonTheme(
      minWidth: isFullWidth ? double.infinity : 150,
      height: 45,
      child: RaisedButton(
          shape: StadiumBorder(),
          color: ColorConst.FCM_APP_COLOR,
          child: getTxtWhiteColor(txt, 15, FontWeight.bold),
          onPressed: () => _loginType(loginType)),
    );
  }

  _loginType(int loginType) async {
    switch (loginType) {
      case 0:
        return SocialLoginHelper.signInType(
            SocialLoginType.GOOGLE, _loginResult);
      case 1:
        return SocialLoginHelper.signInType(
            SocialLoginType.FACEBOOK, _loginResult);
      case 2:
        return SocialLoginHelper.signInType(
            SocialLoginType.TWITTER, _loginResult);
      case 3:
        return navigationPush(context, FcmLoginMobile());
      case 4:
        return navigationPush(context, FcmLogin());
      case 5:
        return navigationPush(context, FcmSignup());
    }
  }

  _loginResult(FirebaseUser fcmUser, bool isUserCancel, String error) {
    if (isUserCancel) {
      print('user canceled');
    } else {
      if (error != null)
        print('user error  :  ' + error);
      else {
        print(fcmUser.displayName);
        navigationPush(_ctx, FcmHome());
      }
    }
  }


}
