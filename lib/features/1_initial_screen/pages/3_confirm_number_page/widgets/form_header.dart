import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp2/features/1_initial_screen/global/location_state.dart';

class ConfirmNumberFormHeader extends StatelessWidget {
  ConfirmNumberFormHeader({
    Key? key,
  }) : super(key: key);

  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          child: Text(
            'Verificando teu numero',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        const Text('Aguarde que um SMS chegará no número'),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () {
                  var countryCode = locationController.countryCodeInputController.value.text;
                  var phoneNumber = locationController.phoneNumberInputController.value.text;
                  return Text(
                    '+$countryCode $phoneNumber. ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 25,
                child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Numero errado?"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}