import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';

import '../../../core/common/loader.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Sector"),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                const Align(
                    alignment: Alignment.topLeft, child: Text("Sector Name")),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: communityNameController,
                  decoration: const InputDecoration(
                    hintText: "r/Sector_name",
                    filled: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  maxLength: 21,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "No Space in the Sector name",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: createCommunity,
                  child: Text("Create Sector",
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                )
              ]),
            ),
    );
  }
}
