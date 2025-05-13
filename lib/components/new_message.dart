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
      _messageController.clear();
      await ChatService().save(_message, user);
    }
  }

  @override
  Widget build(BuildContext context){
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 60, 60, 60),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 60, 60, 60)
              ),
              child: TextField(
                controller: _messageController,
                onChanged: (msg) => setState(() {
                  _message = msg;
                }),
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 120, 120, 120)
                  ),
                  hintText: _messageController.text.isEmpty ? 'Enviar mensagem...' : null,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send, 
              color: const Color.fromARGB(255, 120, 120, 120) 
            ), 
            onPressed: _message.trim().isEmpty 
              ? null : 
              _sendMessage ,
          )
        ],
      ),
    );
  }
}