// Import necessary libraries
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_tutorial/core/constants/firebase_constants.dart';
import 'package:reddit_tutorial/core/providers/firebase_provider.dart';
import 'package:reddit_tutorial/models/user_model.dart';

import '../../../core/constants/constraints.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

// A class that handles authentication related operations
class AuthRepository {
  // Instance of Firestore for database operations
  final FirebaseFirestore _firestore;

  final FirebaseAuth _auth; // Instance of FirebaseAuth for authentication
  final GoogleSignIn
      _googleSignIn; // Instance of GoogleSignIn for Google authentication

  // Constructor to initialize the AuthRepository with required instances
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.usersCollection);

  // Method to sign in using Google authentication
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn(); // Start Google sign-in process

      // Create a GoogleAuthProvider credential using the obtained authentication data
      //It provides our app with an Access token and an id token to allow user to access the app features and to verify the user's identity..
      final credential = GoogleAuthProvider.credential(
        accessToken: (await googleUser?.authentication)?.accessToken,
        idToken: (await googleUser?.authentication)?.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(
          credential); //This will allow us to store the credentials in the firebase

      late UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: userCredential.user!.displayName ?? "No Name",
          profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await _user.doc(userCredential.user!.uid).set(userModel.toMap());
      }
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
