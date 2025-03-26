import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  
  UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
  
  // Create UserModel from Firebase User
  factory UserModel.fromFirebase(firebase_auth.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }
  
  // Create empty user (for not logged in)
  factory UserModel.empty() {
    return UserModel(uid: '');
  }
  
  // Check if user is empty (not logged in)
  bool get isEmpty => uid.isEmpty;
  bool get isNotEmpty => !isEmpty;
} 