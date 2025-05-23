import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messages/core/models/chat_notification.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(ChatNotification notification){
    _items.add(notification);
    notifyListeners();
  }

  void remove(Object i){
    _items.remove(i);
    notifyListeners();
  }

  // Push notification
  Future<void> init() async{
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAuthorized async{
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async{
    if(await _isAuthorized){
      FirebaseMessaging.onMessage.listen(_messageHandler);   
    }
  }

  Future<void> _configureBackground() async{
    if(await _isAuthorized){
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async{
    if(await _isAuthorized){
      RemoteMessage? initialMsg = await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }

  void _messageHandler(RemoteMessage? msg){
    if(msg == null || msg.notification == null) return;   
    add(
      ChatNotification(
        title: msg.notification!.title ?? 'Não informado', 
        body: msg.notification!.body ?? 'Não informado'
      )
    );
  }
}