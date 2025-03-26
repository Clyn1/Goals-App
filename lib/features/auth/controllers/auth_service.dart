import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthResult {
  final UserModel? user;
  final String? errorMessage;
  
  AuthResult({this.user, this.errorMessage});
  
  bool get isSuccess => user != null && errorMessage == null;
  bool get isError => errorMessage != null;
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  // Get current user
  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebase(user);
  }
  
  // Check if user is signed in
  bool get isSignedIn => _firebaseAuth.currentUser != null;
  
  // Sign in with email & password
  Future<AuthResult> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      return AuthResult(user: UserModel.fromFirebase(result.user!));
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'An unexpected error occurred');
    }
  }
  
  // Register with email & password
  Future<AuthResult> registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      return AuthResult(user: UserModel.fromFirebase(result.user!));
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'An unexpected error occurred');
    }
  }
  
  // Google Sign In
  Future<AuthResult> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      // If user cancels the sign-in flow
      if (googleUser == null) {
        return AuthResult(errorMessage: 'Sign in cancelled');
      }
      
      // Get Google auth details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Create Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in with credential
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);
      
      return AuthResult(user: UserModel.fromFirebase(userCredential.user!));
    } catch (e) {
      return AuthResult(errorMessage: 'Failed to sign in with Google');
    }
  }
  
  // Apple Sign In (for iOS only)
  Future<AuthResult> signInWithApple() async {
    try {
      // Create Apple provider
      final appleProvider = AppleAuthProvider();
      
      // Sign in with Apple on iOS
      final UserCredential userCredential =
          await _firebaseAuth.signInWithProvider(appleProvider);
          
      return AuthResult(user: UserModel.fromFirebase(userCredential.user!));
    } catch (e) {
      return AuthResult(errorMessage: 'Failed to sign in with Apple');
    }
  }
  
  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
  
  // Password reset
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return AuthResult(user: null);
    } on FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: _getFirebaseErrorMessage(e.code));
    } catch (e) {
      return AuthResult(errorMessage: 'Failed to send password reset email');
    }
  }
  
  // Get user-friendly error messages
  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password. Please try again';
      case 'invalid-email':
        return 'The email address is not valid';
      case 'user-disabled':
        return 'This user has been disabled';
      case 'email-already-in-use':
        return 'An account already exists for this email';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed';
      case 'weak-password':
        return 'The password is too weak';
      case 'invalid-credential':
        return 'The authentication credential is invalid';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      case 'too-many-requests':
        return 'Too many unsuccessful login attempts. Please try again later';
      default:
        return 'An error occurred. Please try again';
    }
  }
} 