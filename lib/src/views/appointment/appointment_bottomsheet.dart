import 'package:flutter/material.dart';
import 'package:flutterfeatures/src/views/appointment/appointment_controller.dart';

class AppointmentBottomSheet extends StatefulWidget {
  const AppointmentBottomSheet({
    Key? key,
    required this.controller,
    required this.usernameController,
    required this.fontSize,
    required this.onNewModelCreation,
  }) : super(key: key);
  final AppointmentController controller;
  final TextEditingController usernameController;
  final double? fontSize;
  final Function? onNewModelCreation;

  @override
  _AppointmentBottomSheetState createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {
  late bool _isAppointmentInMorning;
  late Color _iconColor;
  late Color _backgroundColor;
  double? fontSize = 15;
  final String _clockIcon = "⏱";
  late String _setTimeText;

  @override
  void initState() {
    _isAppointmentInMorning = true;
    _iconColor = Colors.black;
    _setTimeText = "Tap to set time $_clockIcon";
    widget.controller.setAppointmentTime("");
    _updateUI();
    super.initState();
  }

  _updateUI() {
    setState(() {
      if (_isAppointmentInMorning) {
        _iconColor = Colors.black;
        _backgroundColor = Colors.white;
      } else {
        _iconColor = Colors.white;
        _backgroundColor = const Color.fromARGB(255, 37, 37, 37);
      }
      if (widget.controller.appointmentTime == "" ||
          widget.controller.appointmentTime.contains(_clockIcon)) {
        widget.controller.setAppointmentTime(_setTimeText);
        fontSize = widget.fontSize! * 0.4;
      } else {
        fontSize = widget.fontSize! * 0.8;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            borderRadius: BorderRadius.all(
              Radius.circular(
                widget.fontSize! * 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Icon(
                Icons.save,
                size: widget.fontSize! * 0.5,
                color: _iconColor,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
            ),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 50,
              top: 20,
            ),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(
                  15.0,
                ),
                topLeft: Radius.circular(
                  15.0,
                ),
              ),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.dial,
                        );
                        String currentTime = "";
                        if (newTime != null) {
                          setState(() {
                            _isAppointmentInMorning = !(newTime.hour > 12);
                          });
                          if (_isAppointmentInMorning) {
                            currentTime =
                                "${newTime.hour == 0 ? 12 : newTime.hour}:${newTime.minute} AM";
                          } else {
                            var currentHour = newTime.hour - 12;
                            currentTime = "$currentHour:${newTime.minute} PM";
                          }
                          widget.controller.setAppointmentTime(currentTime);
                          _updateUI();
                        }
                      },
                      child: Text(
                        widget.controller.appointmentTime,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: _iconColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.bedtime,
                      color: _iconColor,
                    ),
                    Switch(
                      value: _isAppointmentInMorning,
                      activeColor: _iconColor,
                      activeTrackColor: _iconColor,
                      inactiveThumbColor: _iconColor,
                      inactiveTrackColor: _iconColor,
                      onChanged: (value) {
                        setState(() {
                          _isAppointmentInMorning = value;
                        });
                        widget.controller.setAppointmentTime("");
                        _updateUI();
                      },
                    ),
                    Icon(
                      Icons.wb_sunny,
                      color: _iconColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: widget.usernameController,
                    style: TextStyle(
                      color: _iconColor,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _iconColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _iconColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _iconColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      hintText: 'Enter name',
                      labelText: 'Enter name',
                      labelStyle: TextStyle(
                        color: _iconColor.withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                      hintStyle: TextStyle(
                        color: _iconColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
