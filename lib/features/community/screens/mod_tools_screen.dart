// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  String name;
  ModToolsScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mod Tools"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Add Moderators"),
            leading: Icon(Icons.add_moderator),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Edit Community"),
            leading: Icon(Icons.edit),
            onTap: () => navigateToModTools(context),
          ),
        ],
      ),
    );
  }
}
