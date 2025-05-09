import 'package:flutter/material.dart';
import 'package:messages/core/services/auth/auth_mock_service.dart';

class ChatScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chat Page"
            ),
            TextButton(
              child: Text("logout"), 
              onPressed: (){
                AuthMockService().logout();
              },
            )
          ],
        ),
      ),
    );
  }
}