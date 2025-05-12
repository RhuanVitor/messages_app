import 'package:flutter/material.dart';
import 'package:messages/core/services/notification/chat_notification_service.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas notificações"),
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (ctx, index){
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].body),
            onTap: () => service.remove(items[index]),
          );
        }
      )
    );
  }
}