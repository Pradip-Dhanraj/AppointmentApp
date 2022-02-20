class AppointmentService {
  Future<List?> getAppointments() async {
    return List.generate(
      3,
      (index) {
        return index;
      },
      growable: true,
    );
  }
}
