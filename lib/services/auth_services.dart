import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sl_salt/exception/expceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sl_salt/models/users.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firestore ?? FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<List<String>> getAllUserUIDs() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

      List<String> userUIDs = querySnapshot.docs.map((doc) => doc.id).toList();

      print("🔎 All User UIDs: $userUIDs");

      return userUIDs;
    } catch (e) {
      print("❌ Error fetching user UIDs: $e");
      return [];
    }
  }

  Future<User?> registerNewUser(String email, String password, String username, String role) async {
    try {
      print("🔍 Checking if username exists...");

      // Check if the username is already taken
      final QuerySnapshot query = await _firebaseFirestore.collection('users').where('userName', isEqualTo: username).get();

      if (query.docs.isNotEmpty) {
        throw CustomException('The Username is already taken.');
      }

      print("✅ Username available. Creating Firebase Authentication user...");

      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        print("✅ User created with UID: ${user.uid}");
        print("📝 Saving user to Firestore...");

        final userModel = UserModel(
          id: user.uid,
          userName: username,
          fullName: username,
          email: email,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          role: role,
        );

        await _firebaseFirestore.collection('users').doc(user.uid).set(userModel.toJson());

        print("✅ User successfully saved to Firestore!");

        // Fetch and print all user UIDs after registration
        List<String> allUserUIDs = await getAllUserUIDs();
        print("📌 All User UIDs after registration: $allUserUIDs");
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message!);
    } on FirebaseException catch (e) {
      throw CustomException(e.message!);
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message!);
    }
  }

  Future<String> getEmailFromUsername(String username) async {
    try {
      final QuerySnapshot query = await _firebaseFirestore.collection('users').where('userName', isEqualTo: username).get();

      if (query.docs.isEmpty) {
        throw CustomException('No user found with this username.');
      }

      return (query.docs.first.data() as Map<String, dynamic>)['email'];
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable') {
        throw CustomException('Network error: Please check your internet connection.');
      } else if (e.code == 'not-found') {
        throw CustomException('User data not found.');
      } else {
        throw CustomException(e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      // Catch other unexpected errors
      throw CustomException('An unexpected error occurred. Please try again later');
    }
  }

  Future<void> signOut() async {
    // Sign out from Firebase
    await _firebaseAuth.signOut();

    // Clear all data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<UserModel> getUserDetails(String userId) async {
    try {
      final DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(userId).get();
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw CustomException(e.message!);
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.updatePassword(newPassword);
        await _firebaseFirestore.collection('users').doc(currentUser.uid).update({'isFirstTime': false});
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message!);
    }
  }

  Future<bool> isFirstTimeLogin(User user) async {
    try {
      final doc = await _firebaseFirestore.collection('users').doc(user.uid).get();
      return doc.exists && doc['isFirstTime'] == true;
    } on FirebaseException catch (e) {
      throw CustomException(e.message!);
    }
  }

  Future<void> validateAndUpdatePassword(String currentPassword, String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message!);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Check if the email exists in Firestore
      final QuerySnapshot query = await _firebaseFirestore.collection('users').where('email', isEqualTo: email).get();

      if (query.docs.isEmpty) {
        throw CustomException('No user found with this email.');
      }

      // Send password reset email
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message!);
    }
  }
}
