import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfeatures/src/views/widgets/animated_tap_widget.dart';
import 'package:flutterfeatures/src/views/appointment/appointment_bottomsheet.dart';
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
  late TextEditingController usernameController;

  @override
  void initState() {
    _isMorningAppointment = true;
    usernameController = TextEditingController();
    usernameController.addListener(() {
      widget.controller.setusername(usernameController.text);
    });
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                AnimatedTapWidget(
                                  onTap: () {
                                    showBottomDrawer(context,
                                        fontSize: LargeTextSize * 3);
                                  },
                                  widget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.add_box,
                                      color: Colors.blueGrey,
                                      size: MediumTextSize * 2,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: AnimatedTapWidget(
                                    onTap: () {},
                                    widget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.refresh,
                                        color: Colors.blueGrey,
                                        size: builder.maxHeight * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedTapWidget(
                                  onTap: () {},
                                  widget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.blueGrey,
                                      size: builder.maxHeight * 0.04,
                                    ),
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
                            boxShadow: _isMorningAppointment
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
                            milliseconds: 400,
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
                            boxShadow: !_isMorningAppointment
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
                            milliseconds: 400,
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
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: FutureBuilder(
                        future: widget.controller.getAppointments(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  itemCount: widget
                                          .controller.appointmentList?.length ??
                                      0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        tileColor: Colors.greenAccent,
                                        title: Text(
                                          'Patients name',
                                          style: getTextStyle(),
                                        ),
                                        subtitle: Text(
                                          'A10021',
                                          style: getTextStyle(),
                                        ),
                                        trailing: AnimatedTapWidget(
                                          widget: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.mode_edit,
                                              color: Colors.blueGrey,
                                              size: LargeTextSize * 1.3,
                                            ),
                                          ),
                                        ),
                                        dense: true,
                                        leading: Text(
                                          'HH:\nmm',
                                          style: getTextStyle(),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const CupertinoActivityIndicator();
                        },
                      ),
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

  TextStyle getTextStyle() => const TextStyle(
        color: Colors.blueGrey,
        fontSize: 20,
      );

  List<Widget> getAppointmentList() {
    var lst = widget.controller.appointmentList!
        .map((index) => SlotView(
              time: "time slot $index",
              isBooked: false,
            ))
        .toList();
    return lst;
  }

  _tapAppoinment(bool isMorningShift) {
    setState(() {
      _isMorningAppointment = isMorningShift;
    });
  }

  void showBottomDrawer(
    BuildContext context, {
    fontSize = 50,
    bool enabled = true,
  }) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return AppointmentBottomSheet(
              fontSize: fontSize,
              controller: widget.controller,
              usernameController: usernameController,
              onNewModelCreation: () {});
        });
  }
}
