class AppointmentModel {
  final String imageUrl;
  final String clientName;
  final String noOfBookings;
  final String sessionType;
  final String goal;
  final List<String> dates;

  AppointmentModel(
      {this.imageUrl,
      this.clientName,
      this.noOfBookings,
      this.sessionType,
      this.goal,
      this.dates});
}
