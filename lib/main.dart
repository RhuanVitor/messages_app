import 'package:flutter/material.dart';
import 'package:messages/core/services/notification/chat_notification_service.dart';
import 'package:messages/screens/auth_or_page_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatNotificationService())
      ],
      
      child: MaterialApp( 
        title: 'Flutter Demo',
        home: AuthOrPageScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

