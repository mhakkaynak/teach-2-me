import 'package:flutter/material.dart';

import '../../../../core/constants/navigation/navigation_constant.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/init/navigation/navigation_manager.dart';
import '../../../../products/firebase/firebase_auth/firebase_auth_service.dart';
import '../../../../products/models/user_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  Widget _buildTextField({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      child: TextField(
        cursorColor: context.currentTheme.primaryColor,
        cursorWidth: 2,
        obscureText: false,
        style: TextStyle(color: context.currentTheme.primaryColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: context.currentTheme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.white,
          ),
          elevation: MaterialStateProperty.all(6),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: context.currentTheme.primaryColor,
          ),
        ),
        onPressed: () {
          FirebaseAuthService.instance?.signInWithEmail(UserModel.login(
              email: _emailTextController.text,
              password: _passwordTextController.text));
          _goToHomeView();
        },
      ),
    );
  }

  Widget _buildLogoButton(
    String image,
    VoidCallback onPressed,
  ) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Image.asset(image),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLogoButton(
          'assets/images/google_logo.png',
          () {
            FirebaseAuthService.instance?.signInWithGoogle();
            _goToHomeView();
          },
        ),
      ],
    );
  }

  void _goToHomeView() {
    NavigationManager.instance
        ?.navigationToPageAndClear(NavigationConstant.home);
  }

  Widget _buildSignUpQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Dont have an Account? ',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        InkWell(
          child: const Text(
            'Sing Up',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Text _buildText(String s) {
    return const Text(
      'Password',
      style: TextStyle(
        fontFamily: 'PT-Sans',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.currentTheme.primaryColor,
                context.currentTheme.colorScheme.secondary,
                context.currentTheme.colorScheme.onPrimary,
                context.currentTheme.colorScheme.onSecondary,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ).copyWith(top: 60),
              child: Column(
                children: [
                  const Text(
                    'Sing in',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: _buildText('Email'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildTextField(
                    hintText: 'Enter your email',
                    obscureText: false,
                    prefixedIcon: Icon(Icons.mail,
                        color: context.currentTheme.colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: _buildText('Password'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildTextField(
                    hintText: 'Enter your password',
                    obscureText: true,
                    prefixedIcon: Icon(Icons.lock,
                        color: context.currentTheme.colorScheme.onPrimary),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildLoginButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '- OR -',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Sign in with',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSocialButtons(),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSignUpQuestion()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
