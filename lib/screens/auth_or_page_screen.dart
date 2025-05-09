import 'package:flutter/material.dart';
import 'package:messages/core/models/chat_user.dart';
import 'package:messages/core/services/auth/auth_mock_service.dart';
import 'package:messages/core/services/auth/auth_service.dart';
import 'package:messages/screens/auth_screen.dart';
import 'package:messages/screens/chat_screen.dart';
import 'package:messages/screens/loading_screen.dart';

class AuthOrPageScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges, 
        builder: (ctx, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingPage();
          } else{
            return snapshot.hasData ? ChatScreen() : AuthScreen();
          }
        }
      )
    );
  }
}