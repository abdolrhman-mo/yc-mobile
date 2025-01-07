import 'package:flutter/material.dart';
import 'package:flutter_application_2/utils/validators.dart';
import 'package:flutter_application_2/screens/auth/signup_page.dart';
import 'package:flutter_application_2/screens/home_page.dart';
import 'package:flutter_application_2/services/auth_service.dart';
import 'package:flutter_application_2/widgets/form_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authService = AuthService();

  late AnimationController buttonController;
  late Animation<double> buttonScale;

  @override
  void initState() {
    super.initState();
    buttonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    buttonScale = Tween<double>(begin: 1.0, end: 1.1).animate(buttonController);
  }

  void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> handleLogin() async {
    if (formKey.currentState!.validate()) {
      final username = usernameController.text;
      final password = passwordController.text;

      final success = await authService.login(username, password);
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        showError('Invalid username or password. Please try again.');
      }
    } else {
      showError("Please fill all required fields.");
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Study Steady',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  FormFieldWidget(
                    controller: usernameController,
                    labelText: 'Username',
                    prefixIcon: Icons.person,
                    validator: (value) =>
                        Validators.validateNonEmpty(value, 'Username'),
                  ),
                  const SizedBox(height: 20),
                  FormFieldWidget(
                    controller: passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    validator: (value) =>
                        Validators.validateNonEmpty(value, 'Password'),
                  ),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: buttonController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: buttonScale.value,
                        child: ElevatedButton(
                          onPressed: () async {
                            buttonController
                                .forward()
                                .then((_) => buttonController.reverse());
                            await handleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
