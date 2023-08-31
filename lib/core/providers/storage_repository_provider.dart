// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/core/failure.dart';
import 'package:reddit_tutorial/core/providers/firebase_provider.dart';

import '../type_def.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(
        storageProvider), //storageProvider contains the instance of firebase-Class from the firebase storage plug-in..
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;
  StorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

//This function(storeFile) takes a file, uploads it to a specific location in Firebase Cloud Storage,
//and returns either a successful download URL as a String
  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(
          id); //It creates a reference to the Firebase Storage location where the file will be stored.

      UploadTask uploadTask = ref.putFile(
          file!); //this is to upload the the file in the firebase storage

      final snapshots = await uploadTask;

      return right(await snapshots.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
