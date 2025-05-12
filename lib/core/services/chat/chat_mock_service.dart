import 'dart:async';
import 'dart:math';
import 'package:messages/core/models/chat_message.dart';
import 'package:messages/core/models/chat_user.dart';
import 'package:messages/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1', 
      text: "teste1", 
      createdAt: DateTime.now(), 
      userId: '123', 
      userName: 'name teste', 
      userImageUrl: 'assets/images/avatar.png'
    ),
    ChatMessage(
      id: '2', 
      text: "teste 2", 
      createdAt: DateTime.now(), 
      userId: '321', 
      userName: 'default user', 
      userImageUrl: 'assets/images/avatar.png'
    ),
    ChatMessage(
      id: '3', 
      text: "teste 3", 
      createdAt: DateTime.now(), 
      userId: '456', 
      userName: 'name teste 3', 
      userImageUrl: 'assets/images/avatar.png'
    ),
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgStream = Stream<List<ChatMessage>>.multi(
    (controller){
      _controller = controller;
      controller.add(_msgs);
    }
  );

  Stream<List<ChatMessage>> messageStream(){
    return _msgStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async{
    
    final newMessage = ChatMessage(
        id: Random().nextInt(1000000).toString(), 
        text: text, 
        createdAt: DateTime.now(), 
        userId: user.id, 
        userName: user.name, 
        userImageUrl: user.imageUrl
      );

    _msgs.add(newMessage);

    _controller?.add(_msgs.reversed.toList());

    return newMessage;
  }
}