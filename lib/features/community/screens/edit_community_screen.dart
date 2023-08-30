// ignore_for_file: public_member_api_docs, sort_constructors_first

//setState(() { bannerFile = ... });:
// setState is called to update the state of the widget and trigger a rebuild of the UI.
// The bannerFile variable is updated with the selected image's File object,
//triggering a UI update that may reflect the new image.

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/common/error_text.dart';
import 'package:reddit_tutorial/core/common/loader.dart';
import 'package:reddit_tutorial/core/utils.dart';
import 'package:reddit_tutorial/features/community/controller/community_controller.dart';
import 'package:reddit_tutorial/theme/pallete.dart';

import '../../../core/constants/constraints.dart';
import '../../../models/community_model.dart';

//

class EditCommunityScreen extends ConsumerStatefulWidget {
  String name;
  EditCommunityScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  ConsumerState<EditCommunityScreen> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first
            .path!); //this line is going to retrive the path of selected image and store it in a FILE-object called banner_file
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  void save(Community community) {
    ref.read(communityControllerProvider.notifier).editCommunity(
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
          community: community,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            appBar: AppBar(
              title: Text("Edit Community"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => save(community),
                  child:
                      const Text("Save", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            body: isLoading
                ? const Loader()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () => selectBannerImage(),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(10),
                                  dashPattern: [10, 4],
                                  strokeCap: StrokeCap.round,
                                  color: Pallete.darkModeAppTheme.textTheme
                                      .bodyMedium!.color!,
                                  child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: bannerFile != null
                                          ? Image.file(bannerFile!)
                                          : community.banner.isEmpty ||
                                                  community.banner ==
                                                      Constants.bannerDefault
                                              ? const Center(
                                                  child: Icon(
                                                    MdiIcons.camera,
                                                    size: 40,
                                                  ),
                                                )
                                              : Image.network(
                                                  community.banner)),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: GestureDetector(
                                  onTap: () => selectProfileImage(),
                                  child: profileFile != null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              FileImage(profileFile!),
                                          radius: 30,
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(community.avatar),
                                          radius: 30,
                                        ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          loading: () => Loader(),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
        );
  }
}
