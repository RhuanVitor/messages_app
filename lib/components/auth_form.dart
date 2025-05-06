import 'dart:io';

import 'package:messages/components/user_image_picker.dart';
import 'package:messages/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color.fromRGBO(13,19,24,1),
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),

              if (_formData.isSignup)
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Nome",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255,34,219,172), width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid)
                        ),
                      ),
                      key: const ValueKey('name'),
                      initialValue: _formData.name,
                      onChanged: (name) => _formData.name = name,
                      validator: (localName) {
                        final name = localName ?? '';
                        if (name.trim().length < 5) {
                          return 'Nome deve ter no mínimo 5 caracteres.';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255,34,219,172), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid)
                  ),
                ),
                validator: (localEmail) {
                  final email = localEmail ?? '';
                  if (!email.contains('@')) {
                    return 'E-mail nformado não é válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Senha",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255,34,219,172), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid)
                  ),
                ),
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true,
                validator: (localPassword) {
                  final password = localPassword ?? '';
                  if (password.length < 6) {
                    return 'Nome deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: _submit,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255,34,219,172),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(_formData.isLogin ? 'Entrar' : 'Criar conta')
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
