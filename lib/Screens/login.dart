import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_management/models/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:hotel_management/heightWidth.dart';

class GoogleLogin extends StatefulWidget {
  static const id = '';
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    return Scaffold(
        backgroundColor: t.primaryColor,
        body: Center(
          child: SizedBox(
            width: context.width * 0.8,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: Text(
                  "Sign up with Google",
                  style: t.textTheme.headline2,
                )),
          ),
        ));
  }
}
