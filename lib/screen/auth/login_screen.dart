import 'dart:ui';

import 'package:gif_view/gif_view.dart';
import 'package:radius/model/auth.dart';
import 'package:radius/screen/dashboard/dashboard_screen.dart';
import 'package:radius/utils/constant.dart';
import 'package:radius/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
// import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  bool initial = true;

  LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => loginScreenState();
}

class loginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void didChangeDependencies() {
    if (widget.initial) {
      widget.initial = false;
      context.read<Auth>().resetAppUrl();
      context.read<Auth>().getAppUrl();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _form.currentState?.dispose();
    super.dispose();
  }

  var _isLoading = false;

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  validateValue() async {
    final value = _form.currentState!.validate();
    if (value) {
      loginUser();
    }
  }

  // void scanQr() {
  //   QrBarCodeScannerDialog().getScannedQrBarCode(
  //       context: context,
  //       onCode: (code) {
  //         context.read<Auth>().saveAppUrl(code ?? "");
  //       });
  // }

  void loginUser() async {
    setState(() {
      _isLoading = true;
      EasyLoading.show(
          status: translate('loader.signing_in'),
          maskType: EasyLoadingMaskType.black);
    });

    try {
      final response = await Provider.of<Auth>(context, listen: false)
          .login(_usernameController.text, _passwordController.text);

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));

      Navigator.of(context)
          .pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }

    setState(() {
      _isLoading = false;
      EasyLoading.dismiss(animation: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasUrl = context.watch<Auth>().appUrl.isNotEmpty;
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: IgnorePointer(
              ignoring: _isLoading,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: !hasUrl
                    ? Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 250,
                                    height: 250,
                                    child: GifView.asset(
                                      'assets/icons/3dgifmaker81257.gif',
                                      width: 250,
                                      height: 250,
                                    ),
                                  ),
                                ),
                                gaps(50),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: HexColor("#ee462c"),
                                        padding: EdgeInsets.zero,
                                        shape: ButtonBorder(),
                                      ),
                                      onPressed: () {
                                        // scanQr();
                                        context.read<Auth>().skipAppUrl();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      )),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     context.read<Auth>().skipAppUrl();
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(20),
                                //     child: Text(
                                //       translate("welcome_screen.skip"),
                                //       style: const TextStyle(
                                //           fontSize: 15, color: Colors.white),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.asset('assets/icons/logo_bnw.png'),
                              ),
                            ),
                            gaps(20),
                            Text(
                              translate("login_screen.login"),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            gaps(20),
                            textHeading("Staff Number"),
                            gaps(10),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              keyboardAppearance: Brightness.dark,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (!validateField(value!)) {
                                  return "Empty Field";
                                }

                                return null;
                              },
                              controller: _usernameController,
                              cursorColor: Colors.white,
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                              ),
                            ),
                            gaps(10),
                            textHeading(translate("login_screen.password")),
                            gaps(10),
                            TextFormField(
                              obscureText: _obscureText,
                              keyboardAppearance: Brightness.dark,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (!validateField(value!)) {
                                  return "Empty Field";
                                }

                                return null;
                              },
                              controller: _passwordController,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.lock, color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                fillColor: Colors.white24,
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10))),
                                suffixIcon: InkWell(
                                  onTap: _toggle,
                                  child: Icon(
                                    _obscureText
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            gaps(30),
                            button(),
                            gaps(20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // openBrowserTab();
                                  print("Hello Forget Password");
                                },
                                child: Text(
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: Colors.white),
                                    translate("login_screen.forget_password")),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<Auth>().resetAppUrl();
                                  },
                                  child: Text(
                                      textAlign: TextAlign.left,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      translate("login_screen.go_back")),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // openBrowserTab() async {
  //   await FlutterWebBrowser.openWebPage(
  //     url: "https://attendance.cyclonenepal.com/password/reset",
  //     customTabsOptions: const CustomTabsOptions(
  //       colorScheme: CustomTabsColorScheme.dark,
  //       shareState: CustomTabsShareState.on,
  //       instantAppsEnabled: true,
  //       showTitle: true,
  //       urlBarHidingEnabled: true,
  //     ),
  //     safariVCOptions: const SafariViewControllerOptions(
  //       barCollapsingEnabled: true,
  //       dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
  //       modalPresentationCapturesStatusBarAppearance: true,
  //     ),
  //   );
  // }

  BoxDecoration backgroundDecoration() {
    return BoxDecoration(
        image: DecorationImage(
      colorFilter: ColorFilter.mode(
          getAppTheme() ? Colors.blueGrey : Colors.black54,
          BlendMode.softLight),
      image: const AssetImage(
        "assets/images/login.jpg",
      ),
      fit: BoxFit.cover,
    ));
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget textHeading(String value) {
    return Text(
        textAlign: TextAlign.left,
        style: const TextStyle(color: Colors.white),
        value);
  }

  Widget button() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: HexColor("#036eb7"),
            padding: EdgeInsets.zero,
            shape: ButtonBorder(),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            validateValue();
          },
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
