import 'package:flutter/material.dart';

class SlotView extends StatefulWidget {
  const SlotView({
    Key? key,
    this.time,
    this.isBooked,
    this.icon,
  }) : super(key: key);
  final String? time;
  final bool? isBooked;
  final Icon? icon;

  @override
  _SlotViewState createState() => _SlotViewState();
}

class _SlotViewState extends State<SlotView> {
  late bool isBooked;
  late String time;
  late bool allowOverridingIcon;
  late bool eleveted;

  @override
  void initState() {
    super.initState();
    eleveted = true;
    updateWidget();
  }

  //updating widget
  void updateWidget() {
    isBooked = widget.isBooked ?? false;
    time = widget.time ?? '';
    allowOverridingIcon = widget.icon != null;
  }

  @override
  void didUpdateWidget(covariant SlotView oldWidget) {
    setState(() {
      updateWidget();
    });
    super.didUpdateWidget(oldWidget);
  }

  void clickEvent() async {
    setState(() => eleveted = !eleveted);
    await Future.delayed(
      const Duration(
        milliseconds: 200,
      ),
      () => setState(() => eleveted = !eleveted),
    );
    if (!allowOverridingIcon) {
      setState(() => isBooked = !isBooked);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var slotColor = allowOverridingIcon
        ? const Color.fromARGB(255, 243, 242, 242)
        : isBooked
            ? Colors.redAccent[100]
            : Colors.transparent;
    var textColor = allowOverridingIcon
        ? Colors.transparent
        : isBooked
            ? Colors.white
            : Colors.teal;
    var text = allowOverridingIcon
        ? ''
        : isBooked
            ? "Booked"
            : "Available";
    return InkWell(
      onTap: clickEvent,
      child: LayoutBuilder(
        builder: (context, builder) {
          var fontSize = builder.maxWidth * 0.16;
          var animatedIcon = AnimatedCrossFade(
            crossFadeState:
                isBooked ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(
              milliseconds: 800,
            ),
            firstChild: Icon(
              Icons.check_circle,
              size: fontSize * 1,
              color: textColor,
            ),
            secondChild: Icon(
              Icons.pending,
              size: fontSize * 1,
              color: textColor,
            ),
          );
          return Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 15,
            ),
            child: AnimatedContainer(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: slotColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: eleveted
                    ? [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(4, 4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              duration: const Duration(
                milliseconds: 300,
              ),
              child: allowOverridingIcon
                  ? Center(
                      child: widget.icon,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        animatedIcon,
                        Text(
                          time,
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize / 1.1,
                          ),
                        ),
                        Text(
                          text,
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
