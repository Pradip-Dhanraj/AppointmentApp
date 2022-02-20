import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfeatures/src/views/appointment/slot_view_animated.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'appointment_controller.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key, required this.controller}) : super(key: key);
  static const routeName = '/appointment';

  final AppointmentController controller;

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late bool _isMorningAppointment;

  @override
  void initState() {
    _isMorningAppointment = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, builder) {
        // ignore: non_constant_identifier_names
        double LargeTextSize = builder.maxWidth * 0.05;
        // ignore: non_constant_identifier_names
        double MediumTextSize = builder.maxWidth * 0.04;
        return SafeArea(
          top: false,
          left: true,
          right: true,
          bottom: false,
          maintainBottomViewPadding: true,
          child: LayoutBuilder(
            builder: (context, builder) {
              return Column(
                children: [
                  Container(
                    height: builder.maxHeight * 0.4,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: SafeArea(
                      minimum: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.blueGrey,
                                  size: builder.maxHeight * 0.04,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(
                              20,
                            ),
                            child: Text(
                              "Appointment Dates",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          CalendarTimeline(
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 5)),
                            onDateSelected: (date) => print(date),
                            leftMargin: 20,
                            monthColor: Colors.blueGrey,
                            dayColor: Colors.teal[200],
                            activeDayColor: Colors.white,
                            activeBackgroundDayColor: Colors.redAccent[100],
                            dotsColor: const Color(0xFF333A47),
                            selectableDayPredicate: (date) => date.day != 23,
                            locale: 'en_ISO',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _tapAppoinment(true);
                        },
                        child: AnimatedContainer(
                          width: builder.maxWidth * 0.45,
                          decoration: BoxDecoration(
                            color: _isMorningAppointment
                                ? Colors.redAccent[100]
                                : Colors.greenAccent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.morning,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: _isMorningAppointment
                                  ? LargeTextSize
                                  : MediumTextSize,
                              color: _isMorningAppointment
                                  ? Colors.white
                                  : Colors.teal[400],
                              fontWeight: _isMorningAppointment
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _tapAppoinment(false);
                        },
                        child: AnimatedContainer(
                          width: builder.maxWidth * 0.45,
                          decoration: BoxDecoration(
                            color: _isMorningAppointment
                                ? Colors.greenAccent
                                : Colors.redAccent[100],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.evening,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: _isMorningAppointment
                                  ? MediumTextSize
                                  : LargeTextSize,
                              color: _isMorningAppointment
                                  ? Colors.teal[400]
                                  : Colors.white,
                              fontWeight: _isMorningAppointment
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: FutureBuilder(
                      future: widget.controller.getAppointments(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return snapshot.hasData
                            ? GridView.count(
                                crossAxisCount: 3,
                                children: getAppointmentList(),
                              )
                            : const CupertinoActivityIndicator();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> getAppointmentList() {
    var lst = widget.controller.appointmentList!
        .map((index) => SlotView(
              time: "time slot $index",
              isBooked: false,
            ))
        .toList();
    lst.insert(
        0,
        const SlotView(
          time: '',
          isBooked: true,
          icon: Icon(
            Icons.add,
            color: Colors.teal,
            size: 50,
          ),
        ));
    return lst;
  }

  _tapAppoinment(bool isMorningShift) {
    setState(() {
      _isMorningAppointment = isMorningShift;
    });
  }
}
