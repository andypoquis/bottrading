import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('HomePage'),
  //     ),
  //     body: SafeArea(
  //       child: Obx(() => Column(
  //             children: [
  //               Text('Capital: ${controller.capital.value}'),
  //               Text('Precio Cripto: ${controller.lastClosePrice.value}'),
  //               Text('Estado:  ${(controller.isBuy.value)}'),
  //               Text('Estado:  ${(controller.estateMarket.value)}'),
  //               Text('Cantidad de Criptos: ${(controller.cantCripto.value)}'),
  //               Text('Precio ${(controller.valueCripto.value)}')
  //             ],
  //           )),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFD),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Bots de Trading',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff213654))),
                    Expanded(child: Container()),
                    NeumorphicButton(
                      onPressed: () => controller.navigationBot1(),
                      style: const NeumorphicStyle(
                        color: Color(0xffF9FAFD),
                        intensity: 50,
                        surfaceIntensity: 50,
                        boxShape: NeumorphicBoxShape.circle(),
                      ),
                      child: const Icon(Icons.settings),
                      drawSurfaceAboveChild: true,
                    ),
                  ],
                )),
            Expanded(flex: 7, child: wrapDevices()),
          ],
        ),
      )),
    );
  }

  Widget wrapDevices() {
    return Wrap(
      runSpacing: 25,
      spacing: 25,
      children: [
        GestureDetector(
            onTap: () => controller.navigationBot1(),
            child: cardBot('Bot Principal')),
        GestureDetector(
            onTap: () => controller.navigationBot2(), child: cardBot('Bot 2')),
        cardBot('Bot 3')
      ],
    );
  }

  Widget cardBot(String text) {
    return Neumorphic(
      style: const NeumorphicStyle(color: Color(0xffF9FAFD), intensity: 75),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network('https://img.icons8.com/ultraviolet/80/000000/bot.png'),
          spaceH(10),
          Text(text,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff213654)))
        ],
      ),
    );
  }

  Widget spaceH(double h) {
    return SizedBox(height: h);
  }

  Widget spaceW(double w) {
    return SizedBox(width: w);
  }
}
