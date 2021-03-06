class AppointmentModel {
  final String clientImageUrl;
  final String trainerImageUrl;
  final String clientEmail;
  final String trainerEmail;
  final String trainerName;
  final String clientName;
  final String noOfBookings;
  final String sessionType;
  final String goal;
  final List<String> dates;
  final String docId;
  final String noOfCompletedSessions;

  AppointmentModel(
      {this.docId,
      this.clientEmail,
      this.clientImageUrl,
      this.clientName,
      this.trainerEmail,
      this.trainerImageUrl,
      this.trainerName,
      this.noOfBookings,
      this.sessionType,
      this.goal,
      this.dates,
      this.noOfCompletedSessions});
}
