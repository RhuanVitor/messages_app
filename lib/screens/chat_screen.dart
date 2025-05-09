import 'package:flutter/material.dart';
import 'package:messages/components/messages.dart';
import 'package:messages/components/new_message.dart';
import 'package:messages/core/services/auth/auth_service.dart';

class ChatScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      Text("logout")
                    ],
                  ),
                ) 
              )
            ], 
            icon: Icon(Icons.more_vert),
            onChanged: (value){
              if(value == 'logout'){
                AuthService().logout();
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage()
          ],
        )
      )
    );
  }
}