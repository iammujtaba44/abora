class TrainerUser {
  final String uId;
  final String bio;
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
