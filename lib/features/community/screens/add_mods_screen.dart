// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/error_text.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';

class AddModsScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModsScreen({
    required this.name,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModScreenState();
}

class _AddModScreenState extends ConsumerState<AddModsScreen> {
  Set<String> uids = {};
  //ctr is added for the box issue that we are facing with intial user(To select the checkbox)..it is used in if statement in the CheckBoxListTile..
  int ctr = 0;

  void addUids(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUids(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void saveMods() {
    ref
        .read(communityControllerProvider.notifier)
        .addMods(widget.name, uids.toList(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modify Mods"),
          actions: [
            IconButton(
                onPressed: () => saveMods(), icon: const Icon(Icons.done))
          ],
        ),
        body: ref.watch(getCommunityByNameProvider(widget.name)).when(
            data: (community) => ListView.builder(
                  itemCount: community.members.length,
                  itemBuilder: (BuildContext context, int index) {
                    final member = community.members[index];

                    return ref.watch(getUserDataProvider(member)).when(
                          data: (user) {
                            if (community.mods.contains(member) && ctr == 0) {
                              uids.add(member);
                            }
                            ctr++;
                            return CheckboxListTile(
                              value: uids.contains(user.uid),
                              onChanged: (val) {
                                if (val!) {
                                  addUids(user.uid);
                                } else {
                                  removeUids(user.uid);
                                }
                              },
                              title: Text(user.name),
                            );
                          },
                          error: (error, stackTrace) => ErrorText(
                            error: error.toString(),
                          ),
                          loading: () => const Loader(),
                        );
                  },
                ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader()));
  }
}
