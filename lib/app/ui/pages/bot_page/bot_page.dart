import 'package:bottrading/app/ui/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/bot_controller.dart';

class BotPage extends GetView<BotController> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('BotPage'),
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
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 3, child: widgetUser()),
          Expanded(flex: 17, child: widgetCard(sizeScreen)),
          Expanded(flex: 15, child: listOperations(sizeScreen)),
        ],
      )),
    );
  }

  Widget widgetUser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://i.pinimg.com/474x/8b/5d/df/8b5ddf76c348a95b6d87347aa60ae5a1.jpg',
                  width: 55,
                ),
              ),
            ),
            spaceW(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Andrés E. Poquis Chávez',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                spaceH(7.5),
                balanceUser()
              ],
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ]),
                  child: const Icon(Icons.settings)),
            )
          ]),
    );
  }

  Widget widgetCard(final sizeScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          spaceH(40),
          Container(
            height: 175,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'ADABUSD',
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Obx(() => Text(
                        'ADA: ${(controller.devices.isEmpty) ? 'Hola' : controller.devices[1].cantCripto} ',
                        style: const TextStyle(
                            color: titleColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600))),
                    spaceH(10),
                    Text('${controller.lastClosePrice.value}',
                        style: const TextStyle(
                            color: titleColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800)),
                    spaceH(10),
                    Text(controller.stateMarket.value,
                        style: const TextStyle(
                            color: sellColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600))
                  ],
                )),
          ),
          Expanded(
            child: Container(),
          ),
          Obx(() => Row(
                children: [
                  cardDescripton(
                      (controller.devices.isEmpty)
                          ? 'Hola'
                          : controller.devices[1].capital!.toStringAsFixed(4),
                      'Ganancia'),
                  Expanded(
                    child: Container(),
                  ),
                  cardDescripton(
                      (controller.devices.isEmpty)
                          ? 'Hola'
                          : controller.devices[1].valueCripto!
                              .toStringAsFixed(4),
                      'Rentabilidad'),
                  Expanded(
                    child: Container(),
                  ),
                  cardDescripton(
                      (controller.devices.isEmpty)
                          ? 'Hola'
                          : controller.devices[1].cantCripto!
                              .toStringAsFixed(4),
                      'Rentabilidad')
                ],
              )),
          Expanded(
            child: Container(),
          ),
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

  Widget cardDescripton(String data, String subtitle) {
    return Container(
      width: 85,
      height: 75,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          spaceH(2),
          Text(subtitle)
        ],
      ),
    );
  }

  Widget balanceUser() {
    return Expanded(
        child: Container(
            width: 100,
            decoration: BoxDecoration(
                color: const Color(0xff09081B),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: const Center(
              child: Text(
                'Ver Saldo',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )));
  }

  Widget listOperations(final sizeScreen) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: ((context, index) => Column(
              children: [cardOperation(sizeScreen), spaceH(10)],
            )));
  }

  Widget cardOperation(final sizeScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        height: 115,
        width: sizeScreen.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('ADABUSD',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Expanded(child: Container()),
                  const Text('2000-02-07 21:53:13',
                      style: TextStyle(
                          color: subtitleColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500))
                ],
              ),
              const Text('Venta',
                  style: TextStyle(
                      color: sellColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
              spaceH(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Precio (BUSD)',
                            style: TextStyle(
                                color: subtitleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        Text('Completado (ADA)',
                            style: TextStyle(
                                color: subtitleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        Text('Comisión (ADA)',
                            style: TextStyle(
                                color: subtitleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        Text('Total (BUSD)',
                            style: TextStyle(
                                color: subtitleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                      ]),
                  Expanded(child: Container()),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('1.234',
                            style: TextStyle(
                                color: titleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        Text('10.4',
                            style: TextStyle(
                                color: titleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        Text('0.0104',
                            style: TextStyle(
                                color: titleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        Text('12.8336',
                            style: TextStyle(
                                color: titleColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                      ]),
                ],
              )
            ]),
      ),
    );
  }
}
