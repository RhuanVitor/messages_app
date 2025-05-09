import 'package:flutter/material.dart';
import 'package:messages/components/message_bubble.dart';
import 'package:messages/core/models/chat_message.dart';
import 'package:messages/core/services/auth/auth_service.dart';
import 'package:messages/core/services/chat/chat_service.dart';

class Messages extends StatelessWidget{

  Widget build(BuildContext context){
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messageStream(), 
      builder: (ctx, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(
            child: Text("Inicie a conversa mandando uma mensagem!"),
          );
        } else{
          final msgs = snapshot.data!;
          
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, index){
              return MessageBubble(
                key: ValueKey(msgs[index].id),
                message: msgs[index],
                beLongsToCurrentUser: currentUser?.id == msgs[index].userId,
              );
            }
          );
        }
      }
    );
  }
}