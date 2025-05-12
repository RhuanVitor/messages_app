import 'package:flutter/material.dart';
import 'package:messages/core/services/auth/auth_service.dart';
import 'package:messages/core/services/chat/chat_service.dart';

class NewMessage extends StatefulWidget{
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';

  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;
    
    if(user != null){
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context){
    
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (msg) => setState(() {
              _message = msg;
            }),
            decoration: InputDecoration(
              labelText: 'Enviar mensagem...',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send), 
          onPressed: _message.trim().isEmpty 
            ? null : 
            _sendMessage ,
        )
      ],
    );
  }
}