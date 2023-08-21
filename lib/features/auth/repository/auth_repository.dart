// Import necessary libraries
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_tutorial/core/constants/firebase_constants.dart';
import 'package:reddit_tutorial/core/failure.dart';
import 'package:reddit_tutorial/core/providers/firebase_provider.dart';
import 'package:reddit_tutorial/models/user_model.dart';

import '../../../core/constants/constraints.dart';
import '../../../core/type_def.dart';

// Provider for AuthRepository instance
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

// Class that handles authentication related operations
class AuthRepository {
  final FirebaseFirestore
      _firestore; // Instance of Firestore for database operations
  final FirebaseAuth _auth; // Instance of FirebaseAuth for authentication
  final GoogleSignIn
      _googleSignIn; // Instance of GoogleSignIn for Google authentication

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  // Reference to the "users" collection in Firestore
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  // Stream that emits changes in the authentication state
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // Method to sign in using Google authentication
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      // Start Google sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Create a GoogleAuthProvider credential using the obtained authentication data
      final credential = GoogleAuthProvider.credential(
        accessToken: (await googleUser?.authentication)?.accessToken,
        idToken: (await googleUser?.authentication)?.idToken,
      );

      // Sign in with the created credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      UserModel userModel;

      // Check if the user is new or existing
      if (userCredential.additionalUserInfo!.isNewUser) {
        // Create a new UserModel for new users and save to Firestore
        userModel = UserModel(
          name: userCredential.user!.displayName ?? "No Name",
          profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: [],
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        // Retrieve existing UserModel data from Firestore
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel); // Return the UserModel using the Either monad
    } on FirebaseException catch (e) {
      throw e.message!; // Throw FirebaseException message
    } catch (e) {
      return Left(
          Failure(e.toString())); // Return Failure using the Either monad
    }
  }

//method to get the userData when ever it is needed in the app.
  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}


  // TODO : !!!! Edit later : streams and dynaimic list
  // Stream<UserModel> getUserData(String uid) {
  //   return _users.doc(uid).snapshots().map((event) {
  //     final data = event.data();
  //     if (data != null) {
  //       return UserModel.fromMap(data as Map<String, dynamic>);
  //     } else {
  //       throw Exception("User data not found");
  //     }
  //   });
  // }

//In the context of databases and data management, a snapshot is a representation of data at a specific point in time. It captures the state of the data at that moment and is often used for creating backups, restoring data to a previous state, or maintaining historical records.
