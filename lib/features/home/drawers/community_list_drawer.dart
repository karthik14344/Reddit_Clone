import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push("/create-community");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        child: SafeArea(
            child: Column(
      children: [
        ListTile(
          title: Text("Create a Community"),
          leading: Icon(MdiIcons.plus),
          onTap: () => navigateToCreateCommunity(context),
        )
      ],
    )));
  }
}
