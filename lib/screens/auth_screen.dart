import 'package:messages/components/auth_form.dart';
import 'package:messages/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:messages/core/services/auth/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if(!mounted) return;
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        await AuthService().login(
          formData.email.trim(), 
          formData.password
        );
      } else {
        await AuthService().signup(
          formData.name, 
          formData.email.trim(), 
          formData.password, 
          formData.image
        );
      }
    } catch (error) {
      // Tratar erro!
    } finally {
      if(!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 19, 24, 1),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
