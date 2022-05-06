import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/common/navigator/go_to_page.dart';
import 'package:whatsapp2/common/state/user_state.dart';
import 'package:whatsapp2/common/widgets/loading.dart';
import 'package:whatsapp2/features/2_app/3_configuracoes/widgets/1_user_identity/widgets/1_user_details.dart';

import '../../../../../common/widgets/user_photo.dart';

class UserIdentity extends StatelessWidget {
  UserIdentity({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        User? currentUser = userController.user.value;
        if (currentUser == null) {
          return const Loading();
        }
        var name = currentUser.displayName;
        var metaData = currentUser.metadata;
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Hero(
                  tag: 'avatar',
                  child: UserPhotoWidget(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name ?? 'SEM NOME AINDA'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(metaData.creationTime.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            goToPage(
              UserDetails(
                key: const Key('userdetails'),
              ),
            );
          },
        );
      },
    );
  }
}

class ChangeNameBottomSheet extends StatefulWidget {
  const ChangeNameBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeNameBottomSheet> createState() => _ChangeNameBottomSheetState();
}

class _ChangeNameBottomSheetState extends State<ChangeNameBottomSheet> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("CANCELAR"),
              ),
              TextButton(
                onPressed: () async {
                  var newUserName = nameController.text;
                  Get.back();
                  await FirebaseAuth.instance.currentUser?.updateDisplayName(newUserName).then(
                        (value) => {
                          Get.showSnackbar(
                            const GetSnackBar(
                              duration: Duration(milliseconds: 2000),
                              title: "Success",
                              message: ":)",
                            ),
                          )
                        },
                      );
                },
                child: const Text("SALVAR"),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Insira seu nome',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextField(
              controller: nameController,
              autofocus: true,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}