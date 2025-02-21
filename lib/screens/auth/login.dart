import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lms_app/services/auth_service.dart';
import 'package:lms_app/utils/api_next_screen.dart'; // Import đúng ApiNextScreen
import '../api_splash_screen.dart';
import 'sign_up.dart';


class LoginScreen extends StatefulWidget {
  final bool popUpScreen;
  const LoginScreen({super.key, this.popUpScreen = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _btnController = RoundedLoadingButtonController();
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    _btnController.start();

    final result = await _authService.login(_emailController.text, _passwordController.text);

    if (result != null) {
      print("✅ Tokens received: ${result['token']}");

      // Lưu studentId vào SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('studentId', result['studentId']); // Đảm bảo lưu đúng studentId

      _btnController.success();

      // Sử dụng ApiNextScreen thay vì NextScreen
      ApiNextScreen.closeOthersAnimation(context, const ApiSplashScreen());
    } else {
      print("❌ Login failed");
      _btnController.error();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email or password is incorrect!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 2), () {
        _btnController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Log in to access VirtualCourse',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20),

              // **Email**
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: 'Enter email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _emailController.clear(),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Email cannot be blank" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  hintText: 'Enter password',
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => value!.isEmpty ? "Password cannot be blank" : null,
              ),
              const SizedBox(height: 10),

              // **Quên mật khẩu**
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // **Nút đăng nhập**
              RoundedLoadingButton(
                controller: _btnController,
                onPressed: _handleLogin,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // **Đăng ký tài khoản**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No account?",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      "Create an Account",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
