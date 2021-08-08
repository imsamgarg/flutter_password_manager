import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/app/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                child: InputWidget(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  verSpacing20,
                  Expanded(child: NumberRow(numbers: [1, 2, 3])),
                  verSpacing20,
                  Expanded(child: NumberRow(numbers: [4, 5, 6])),
                  verSpacing20,
                  Expanded(child: NumberRow(numbers: [7, 8, 9])),
                  verSpacing20,
                  Expanded(child: BottomRow()),
                  verSpacing30,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomRow extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horSpacing20,
        Expanded(
          child: NumberWidget(
            child: Icon(
              Icons.check_rounded,
              size: 30,
            ),
            color: CustomColors.swatch3.withOpacity(0.3),
          ),
        ),
        horSpacing20,
        Expanded(child: NumberWidget(number: 0)),
        horSpacing20,
        Expanded(
          child: NumberWidget(
            child: Icon(
              Icons.backspace,
              size: 30,
            ),
            color: CustomColors.swatch7.withOpacity(0.3),
            onTap: controller.removeNumber,
            onLongPress: controller.clearNumber,
          ),
        ),
        horSpacing20
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}

class NumberRow extends GetView<LoginController> {
  final List<int> numbers;
  const NumberRow({
    Key? key,
    required this.numbers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        horSpacing20,
        Expanded(
          child: NumberWidget(
            number: numbers[0],
            onTap: () => controller.addNumber(numbers[0]),
          ),
        ),
        horSpacing20,
        Expanded(
          child: NumberWidget(
            number: numbers[1],
            onTap: () => controller.addNumber(numbers[1]),
          ),
        ),
        horSpacing20,
        Expanded(
          child: NumberWidget(
            number: numbers[2],
            onTap: () => controller.addNumber(numbers[2]),
          ),
        ),
        horSpacing20
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
}

class InputWidget extends GetView<LoginController> {
  const InputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.number.text
          .size(55)
          .color(Vx.white)
          .letterSpacing(20)
          .bold
          .make()),
    );
  }
}

class NumberWidget extends StatelessWidget {
  final Widget? child;
  final int? number;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const NumberWidget({
    Key? key,
    this.child,
    this.onTap,
    this.onLongPress,
    this.number,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? CustomColors.swatch5.withOpacity(0.2),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: onTap ?? () {},
        onLongPress: onLongPress,
        child: Center(
          child: (child ?? ("$number").text.color(Colors.grey).size(35).make()),
        ),
      ),
    );
  }
}
