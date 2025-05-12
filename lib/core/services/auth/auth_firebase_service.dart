import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:messages/core/models/chat_user.dart';
import 'package:messages/core/services/auth/auth_service.dart';

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

 @override
 Future<void> signup(
  String name, String email, String password, File? image) async {
    final signup = await Firebase.initializeApp(
    name: 'userSignup',
    options: Firebase.app().options,
    ); 
    
    final auth = FirebaseAuth.instanceFor(app: signup);
    
    UserCredential credential = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
    );
    
    if (credential.user != null) {
      
    final imageName = '${credential.user!.uid}.jpg';
    final imageUrl = await _uploadUserImage(image, imageName);
    
    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageUrl);
    
    await login(email, password);
    
    _currentUser = _toChatUser(credential.user!, name);
    await _saveChatUser(_currentUser!);
    }
    
    await signup.delete();
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

  Future<String?> _uploadUserImage(File? image, String imageName) async{
    if(image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef  = storage.ref().child('user_images').child(imageName);

    try {
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }

  Future<void> _saveChatUser(ChatUser user) async{
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return await docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl
    });
  }

  static ChatUser _toChatUser(User user, [String? imageUrl]){
    return ChatUser(
      id: user.uid, 
      name: user.displayName ?? user.email!.split('@')[0], 
      email: user.email!, 
      imageUrl: imageUrl ?? user.photoURL ?? 'assets/images/avatar.png'
    );
  }

}