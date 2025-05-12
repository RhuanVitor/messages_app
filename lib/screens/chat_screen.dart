import 'dart:math';

import 'package:flutter/material.dart';
import 'package:messages/components/messages.dart';
import 'package:messages/components/new_message.dart';
import 'package:messages/core/models/chat_notification.dart';
import 'package:messages/core/services/auth/auth_service.dart';
import 'package:messages/core/services/notification/chat_notification_service.dart';
import 'package:messages/screens/notification_screen.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
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
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications), 
                onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx){
                        return NotificationScreen();
                      }
                    )
                  );
                }
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  maxRadius: 10,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
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
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //     Provider.of<ChatNotificationService>(context, listen: false).add(
      //       ChatNotification(
      //         title: "Mais uma notificação",
      //         body: Random().nextInt(1000).toString()
      //       )
      //     );
      //   }
      // ),
    );
  }
}