import 'package:radius/provider/createtadacontroller.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class CreateTadaScreen extends StatelessWidget {
  const CreateTadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(CreateTadaController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(translate('create_tada_screen.create_tada')),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10)))),
                onPressed: () {
                  model.checkForm();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(translate('create_tada_screen.submit')),
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: model.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: model.titleController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: translate('create_tada_screen.title'),
                      hintStyle: const TextStyle(color: Colors.white70),
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.white24,
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: model.descriptionController,
                    maxLines: 5,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: translate('create_tada_screen.description'),
                      hintStyle: const TextStyle(color: Colors.white70),
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.white24,
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: model.expensesController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field is required";
                      }
                      return null;
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: translate('create_tada_screen.total_expenses'),
                      hintStyle: const TextStyle(color: Colors.white70),
                      labelStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.white24,
                      filled: true,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      translate('create_tada_screen.add_attachment'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      model.onFileClicked();
                    },
                    child: const Card(
                        shape: CircleBorder(),
                        color: Colors.white54,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  Obx(
                    () => ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: model.fileList.length,
                      itemBuilder: (context, index) {
                        final file = model.fileList[index];
                        return ListTile(
                          title: Text(
                            file.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                model.removeItem(index);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
