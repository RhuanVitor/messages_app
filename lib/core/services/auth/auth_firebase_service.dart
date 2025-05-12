import 'dart:async';
import 'dart:io';

import 'package:messages/core/models/chat_user.dart';
import 'package:messages/core/services/auth/auth_service.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements AuthService{
  static final _defaultUser = ChatUser(
    id: "321",
    name: "default user",
    email: "user@default.com",
    imageUrl: 'assets/images/avatar.png',
  );

  static Map<String, ChatUser> _users = {_defaultUser.email: _defaultUser };
  static ChatUser? _currentUser;
  
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for(final user in authChanges){
      _currentUser = user == null ? null : _toChatUser(user);

      controller.add(_currentUser);
    }
    // _updateUser(_defaultUser);
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
      final auth = FirebaseAuth.instance;
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password
      );
      
      if(credential.user == null){return;}

      credential.user?.updateDisplayName(name);

      // credential.user?.updatePhotoURL(image)
    }

  Future<void> login(String email, String password) async{
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> logout() async{
    FirebaseAuth.instance.signOut();
  }

  static ChatUser _toChatUser(User user){
    return ChatUser(
      id: user.uid, 
      name: user.displayName ?? user.email!.split('@')[0], 
      email: user.email!, 
      imageUrl: user.photoURL ?? 'assets/images/avatar.png'
    );
  }
}