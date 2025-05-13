import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messages/core/models/chat_message.dart';

class MessageBubble extends StatelessWidget{
  static const _defaultUserImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool beLongsToCurrentUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.beLongsToCurrentUser
  }) : super(key: key);

  Widget _showUserImage(String imageUrl){
    ImageProvider? provider;

    final uri = Uri.parse(imageUrl);

    if(uri.scheme.contains('http')){
      provider = NetworkImage(uri.toString());
    } else if(uri.path.contains(_defaultUserImage)){
      provider = AssetImage(_defaultUserImage);
    }else {
      provider = FileImage(File(uri.toString()));
    } 

    return CircleAvatar(
      backgroundColor: Colors.pink,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        Row(
          mainAxisAlignment: beLongsToCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: beLongsToCurrentUser ? Color.fromARGB(255,34,219,172) : const Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(beLongsToCurrentUser ? 0 : 15),
                  topLeft: Radius.circular(beLongsToCurrentUser ? 15 : 0),
                )
              ),
              width: 200,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8
              ),
              child: Column(
                crossAxisAlignment: beLongsToCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: beLongsToCurrentUser ? Colors.black : Colors.white
                    ),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(
                      color: beLongsToCurrentUser ? Colors.black : Colors.white
                    ),
                  ),  
                  Text(
                    DateFormat('HH:mm').format(message.createdAt),
                    style: TextStyle(
                      color: beLongsToCurrentUser ? Colors.black54: Colors.grey,
                      fontSize: 10
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: beLongsToCurrentUser ? null : 180,
          right: beLongsToCurrentUser ? 180 : null,
          child: _showUserImage(message.userImageUrl)
        )
      ],
    );
  }
}