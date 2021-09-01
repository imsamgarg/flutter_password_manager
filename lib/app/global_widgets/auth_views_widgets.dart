import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:password_manager/app/global_widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:password_manager/app/core/theme/app_theme.dart';
import 'package:password_manager/app/core/theme/color_theme.dart';
import 'package:password_manager/app/interfaces/auth_interface.dart';

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
      color: color ?? ColorTheme.numberKeyColor,
      borderRadius: BorderTheme.borderRadL,
      child: InkWell(
        borderRadius: BorderTheme.borderRadL,
        onTap: onTap,
        onLongPress: onLongPress,
        child: Center(
          child: (child ?? ("$number").text.color(Colors.grey).size(35).make()),
        ),
      ),
    );
  }
}

class NumberRow extends StatelessWidget {
  final List<int> numbers;
  final AuthInterface controller;
  const NumberRow({
    required this.controller,
    required this.numbers,
  });

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

class InputWidget extends StatelessWidget {
  final String number;

  const InputWidget({required this.number});

  // final AuthInterface controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child:
          (number.text.size(55).color(Vx.white).letterSpacing(20).bold.make()),
    );
  }
}

class BottomRow extends StatelessWidget {
  final AuthInterface controller;

  const BottomRow({Key? key, required this.controller}) : super(key: key);
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
            color: ColorTheme.primaryColor,
            onTap: controller.verifyNumber,
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
            color: ColorTheme.accentColor,
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

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AuthInterface controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          verSpacing20,
          Expanded(
            child: NumberRow(
              numbers: [1, 2, 3],
              controller: controller,
            ),
          ),
          verSpacing20,
          Expanded(
              child: NumberRow(
            numbers: [4, 5, 6],
            controller: controller,
          )),
          verSpacing20,
          Expanded(
            child: NumberRow(
              numbers: [7, 8, 9],
              controller: controller,
            ),
          ),
          verSpacing20,
          Expanded(
            child: BottomRow(
              controller: controller,
            ),
          ),
          verSpacing30,
        ],
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  final String hint;
  final bool isPassObscure;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final VoidCallback togglePassVisibility;
  final String? Function(String?)? validator;

  const PasswordWidget({
    required this.hint,
    required this.isPassObscure,
    required this.togglePassVisibility,
    required this.controller,
    this.validator,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassObscure,
      validator: validator,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: ShowPasswordToggle(
          isHidden: isPassObscure,
          onTap: togglePassVisibility,
        ),
      ),
    );
  }
}
