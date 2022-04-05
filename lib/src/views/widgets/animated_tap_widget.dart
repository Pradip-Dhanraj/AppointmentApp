import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedTapWidget extends StatefulWidget {
  final Widget widget;
  BoxShadow? firstboxshadow;
  BoxShadow? secondboxshadow;
  Function? onTap;

  AnimatedTapWidget({
    Key? key,
    this.firstboxshadow,
    this.secondboxshadow,
    required this.widget,
    this.onTap,
  }) : super(key: key);

  @override
  _AnimatedTapWidgetState createState() => _AnimatedTapWidgetState();
}

class _AnimatedTapWidgetState extends State<AnimatedTapWidget> {
  late bool elevated;
  late BoxShadow firstboxshadow;
  late BoxShadow secondboxshadow;

  @override
  void initState() {
    super.initState();
    elevated = false;
    firstboxshadow = widget.firstboxshadow ??
        BoxShadow(
          color: Colors.grey.shade500,
          offset: const Offset(4, 4),
          blurRadius: 5,
          spreadRadius: 0.1,
        );
    secondboxshadow = widget.secondboxshadow ??
        const BoxShadow(
          color: Color.fromARGB(255, 9, 228, 202),
          offset: Offset(-4, -4),
          blurRadius: 5,
          spreadRadius: 0.1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        widget.onTap!();
        setState(() {
          elevated = !elevated;
        });
        await Future.delayed(
          const Duration(
            milliseconds: 200,
          ),
          () => setState(() => elevated = !elevated),
        );
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: elevated
              ? [
                  firstboxshadow,
                  secondboxshadow,
                ]
              : null,
        ),
        duration: const Duration(
          milliseconds: 300,
        ),
        child: widget.widget,
      ),
    );
  }
}
