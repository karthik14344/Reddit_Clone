// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/core/failure.dart';
import 'package:reddit_tutorial/core/providers/firebase_provider.dart';
import 'package:reddit_tutorial/models/community_model.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../../core/type_def.dart';

final CommunityRepositoryProvider = Provider((ref) {
  return CommunityRepository(firestore: ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

//createCommunity method takes a Community object as a parameter. Presumably, the Community model contains information about a community that is to be created.
  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw "Community with same name already exirts";
      }
      return right(_communities.doc(community.name).set(community.toMap()));
      //If the document with the same name does not exist, it attempts to create a new document with the community.toMap() data (converted to a map) in the Firestore collection.
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

//communities collection reference
  CollectionReference get _communities =>
      _firestore.collection(FirebaseConstants.communitiesCollection);
}