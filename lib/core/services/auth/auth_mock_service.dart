import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:messages/core/models/chat_user.dart';
import 'package:messages/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService{
  static final _defaultUser = ChatUser(
    id: "321",
    name: "default user",
    email: "user@default.com",
    imageUrl: 'assets/images/avatar.png',
  );

  static Map<String, ChatUser> _users = {_defaultUser.email: _defaultUser };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller){
    _controller = controller;
    _updateUser(_defaultUser);
  });

  ChatUser? get currentUser{
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name, 
    String email, 
    String password, 
    File? image
    ) async {
      final newUser = ChatUser(
        id: Random().nextInt(1000000).toString(), 
        name: name, 
        email: email, 
        imageUrl: image?.path ?? 'assets/images/avatar.png'
      );

      _users.putIfAbsent(email, () => newUser);
      _updateUser(newUser);
    }

  Future<void> login(String email, String password) async{
    _updateUser(_users[email]);
  }
  Future<void> logout() async{
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user){
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}