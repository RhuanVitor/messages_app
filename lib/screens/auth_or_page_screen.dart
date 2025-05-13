import 'package:flutter/material.dart';
import 'package:messages/core/models/chat_user.dart';
import 'package:messages/core/services/auth/auth_service.dart';
import 'package:messages/core/services/notification/chat_notification_service.dart';
import 'package:messages/screens/auth_screen.dart';
import 'package:messages/screens/chat_screen.dart';
import 'package:messages/screens/loading_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class AuthOrPageScreen extends StatelessWidget{

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    Provider.of<ChatNotificationService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot){

        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingPage();
        } else{
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges, 
            builder: (ctx, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return LoadingPage();
              } else{
                return snapshot.hasData ? ChatScreen() : AuthScreen();
              }
            }
          );
        }  
      }
    );
  }
}