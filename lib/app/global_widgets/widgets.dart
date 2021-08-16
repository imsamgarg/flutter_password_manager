import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  const LoadingWidget({Key? key, this.size, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitThreeBounce(
          color: color ?? Theme.of(context).primaryColor,
          size: size ?? 50,
        ),
      ),
    );
  }
}
