import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  get style => null;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    communityNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Community"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: [
          Align(alignment: Alignment.topLeft, child: Text("Community Name")),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: communityNameController,
            decoration: InputDecoration(
              hintText: "r/Community_name",
              filled: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
            maxLength: 21,
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Create Community", style: TextStyle(fontSize: 17)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          )
        ]),
      ),
    );
  }
}
