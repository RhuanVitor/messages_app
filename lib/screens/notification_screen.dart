import 'package:flutter/material.dart';
import 'package:messages/core/services/notification/chat_notification_service.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white, onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Text(
          "Minhas notificações",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, index){
          return ListTile(
            title: Text(
              items[index].title,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            subtitle: Text(
              items[index].body,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onTap: () => service.remove(items[index]),
          );
        }
      )
    );
  }
}