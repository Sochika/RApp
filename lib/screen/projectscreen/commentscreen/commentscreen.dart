import 'package:cached_network_image/cached_network_image.dart';
import 'package:radius/model/member.dart';
import 'package:radius/screen/projectscreen/commentscreen/commentscreencontroller.dart';
import 'package:radius/screen/projectscreen/commentscreen/widget/commentlist.dart';
import 'package:radius/screen/projectscreen/commentscreen/widget/mentionbottomsheet.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<TextFieldAutoCompleteState<String>> textFieldAutoCompleteKey =
        GlobalKey();
    final model = Get.put(CommentScreenController());
    List<Member> value = Get.arguments['members'];
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(translate('comment_list_screen.comments')),
        ),
        body: GestureDetector(
          onVerticalDragDown: (details) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 0, left: 10, right: 10, bottom: 90, child: Column(
                      children: [
                        const Expanded(child: CommentList()),
                        GestureDetector(
                          onTap: () {
                            model.getComments();
                          },
                          child: Obx(() => model.commentList.isNotEmpty?Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(translate('comment_list_screen.load_more_comments'),style: const TextStyle(color: Colors.white),),
                            ):const SizedBox.shrink(),
                          ),
                        )
                      ],
                    )),
                const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 90,
                    child: Divider(
                      color: Colors.white54,
                      endIndent: 10,
                      indent: 10,
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: RadialDecoration(),
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: model.mentionList.length,
                                        itemBuilder: (context, index) {
                                          final member = model.mentionList[index];
                                          return Card(
                                            color: Colors.white54,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      member.name,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        model.removeMember(member);
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(MentionBottomSheet(value),
                                          isDismissible: true,
                                          enableDrag: true,
                                          isScrollControlled: false,
                                          ignoreSafeArea: true);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Obx(
                                    () => CachedNetworkImage(
                                      imageUrl:model.user.value.avatar,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Expanded(
                                  child: TextFormField(
                                focusNode: model.focusNode,
                                autofocus: false,
                                controller: model.commentController,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(color: Colors.white, fontSize: 15),
                                validator: (value) {
                                  return null;
                                },
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                    hintText: translate('comment_list_screen.write_your_comment'),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey, fontSize: 15),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10.0)),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    labelStyle: const TextStyle(color: Colors.white),
                                    filled: true,
                                    fillColor: Colors.transparent),
                              )),
                              GestureDetector(
                                onTap: () {
                                  model.saveComments();
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
