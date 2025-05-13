import 'package:flutter/material.dart';
import 'package:messages/components/chat_date_separator.dart';
import 'package:messages/components/message_bubble.dart';
import 'package:messages/core/models/chat_message.dart';
import 'package:messages/core/services/auth/auth_service.dart';
import 'package:messages/core/services/chat/chat_service.dart';

class Messages extends StatefulWidget{

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  Widget build(BuildContext context){
    final currentUser = AuthService().currentUser;

    DateTime? dateOfCurrentMessage;

    DateTime formatedDate(DateTime date){
      return DateTime(date.year, date.month, date.day);
    }

    bool isFirstMessageInDate(DateTime message_date){

      if(dateOfCurrentMessage != message_date){
        dateOfCurrentMessage = message_date;
        return true;
      } else{
        return false;
      }
    }

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messageStream(), 
      builder: (ctx, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(
            child: Text("Inicie a conversa mandando uma mensagem!"),
          );
        } else{
          final msgs = snapshot.data!;
          
          return ListView.builder(
            reverse: false,
            itemCount: msgs.length,
            itemBuilder: (ctx, index){
              final msg = msgs[index];
              
              return Column(
                children: [
                  
                  if(isFirstMessageInDate(formatedDate(msg.createdAt)))
                  ChatDateSeparator(date: formatedDate(msg.createdAt)),

                  MessageBubble(
                    key: ValueKey(msg.id),
                    message: msg,
                    beLongsToCurrentUser: currentUser?.id == msgs[index].userId,
                  ),
                ],
              );
            }
          );
        }
      }
    );
  }
}