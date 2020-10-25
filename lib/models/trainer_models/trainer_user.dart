class TrainerUser {
  final String uId;
  final String bio;
  final String area;
  final String speciality;
  final String homeTraining;
  final String gymTraining;
  final String pricePerSession;
  final String paymentMethod;
  final String name;
  final String email;
  final String password;
  final String totalViews;
  final String thisMonthVisits;
  final String totalSessionsBooked;
  final String totalBookingThisMonth;
  final String booking;
  final String visit;
  final String ratio;
  final String conversionRate;

  TrainerUser(
      {this.uId,
      this.bio,
      this.area,
      this.speciality,
      this.homeTraining,
      this.gymTraining,
      this.pricePerSession,
      this.paymentMethod,
      this.email,
      this.name,
      this.password,
      this.totalViews,
      this.thisMonthVisits,
      this.totalSessionsBooked,
      this.totalBookingThisMonth,
      this.booking,
      this.visit,
      this.ratio,
      this.conversionRate});
}
