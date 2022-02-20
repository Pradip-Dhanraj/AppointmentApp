import 'package:flutter/material.dart';

class SlotView extends StatelessWidget {
  const SlotView({
    Key? key,
    required this.time,
    required this.isBooked,
  }) : super(key: key);
  final String time;
  final bool isBooked;
  @override
  Widget build(BuildContext context) {
    var slotColor = isBooked ? Colors.redAccent[100] : Colors.greenAccent;
    var textColor = isBooked ? Colors.white : Colors.teal;
    var text = isBooked ? "Booked" : "Available";
    return LayoutBuilder(
      builder: (context, builder) {
        var fontSize = builder.maxWidth * 0.16;
        var icon = isBooked
            ? Icon(
                Icons.check_circle_rounded,
                size: fontSize * 1,
                color: textColor,
              )
            : Icon(
                Icons.pending_actions_rounded,
                size: fontSize * 1,
                color: textColor,
              );
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 15,
          ),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: slotColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
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
    );
  }
}
