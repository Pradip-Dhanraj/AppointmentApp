import 'package:flutter/material.dart';

class AddSlotView extends StatefulWidget {
  const AddSlotView({Key? key}) : super(key: key);

  @override
  _AddSlotViewState createState() => _AddSlotViewState();
}

class _AddSlotViewState extends State<AddSlotView> {
  @override
  Widget build(BuildContext context) {
    var slotColor = Colors.transparent;
    var textColor = Colors.teal;

    return LayoutBuilder(
      builder: (context, builder) {
        var fontSize = builder.maxWidth * 0.16;
        var icon = Icon(
          Icons.add,
          size: fontSize * 1,
          color: textColor,
        );
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 15,
          ),
          child: InkWell(
            onTap: () {},
            child: AnimatedContainer(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: slotColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
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
                ],
              ),
              duration: const Duration(
                milliseconds: 200,
              ),
              child: Center(
                child: icon,
              ),
            ),
          ),
        );
      },
    );
  }
}
