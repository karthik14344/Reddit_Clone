import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/error_text.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:routemaster/routemaster.dart';

import '../../../models/community_model.dart';
import '../../auth/controller/auth_controller.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push("/create-community");
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
        child: SafeArea(
            child: Column(
      children: [
        ListTile(
          title: Text("Create a Community"),
          leading: Icon(MdiIcons.plus),
          onTap: () => navigateToCreateCommunity(context),
        ),
        ref.watch(userCommunityProvider).when(
            data: (communities) => Expanded(
                  child: ListView.builder(
                    itemCount: communities.length,
                    itemBuilder: (BuildContext context, int index) {
                      final community = communities[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(community.avatar),
                        ),
                        title: Text('r/${community.name}'),
                        onTap: () {
                          navigateToCommunity(context, community);
                        },
                      );
                    },
                  ),
                ),
            error: ((error, stackTrace) => ErrorText(
                  error: error.toString(),
                )),
            loading: () => const Loader())
      ],
    )));
  }
}
