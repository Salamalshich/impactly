// import 'package:impactlyflutter/View/EventDetails/EventDetails.dart';

class AppApi {
  static String url = "http://10.0.2.2:8000/api";
  static String urlimage = "http://10.0.2.2:8000/Storage";

  //Auth
  static String LOGIN = '/login';
  static String REGISTER = '/register';
  static String GOVERNORATES = '/governorates';
  static String DistrictEvents = '/district-events';
  static String GetProfile = '/profile';
  static String UpdateProfile = '/profile';

  ///////////////////
  static String GetMyEvent = '/my-events';
  static String AddEvent = '/events';
  static String UpdateEvent(int id) => '/events/$id';
  static String DeleteEvent(int id) => '/events/$id';
  static String RegisterOnEvent(int id) => '/events/$id/register';
  static String MyRegisteredEvents = '/my-registered-events';

  static String WithdrawFromEvent(int id) =>
      '/volunteer-registrations/$id/withdraw';
  static String EventDetails(int id) => '/events/$id';

  static String ScanQR = '/scan-qr';
  static String VerifyHours(int id) => '/verify-hours/$id';
  static String VolunteerNoShow(int id) => '/volunteer-no-show/$id';
  static String CompleteEvent(int id) => '/completeEvent/$id';
  static String FeedbackEvent(int id) =>
      '/volunteer-registrations/$id/feedback';

  ///////////////////
  static String GetMyPledges = '/my-pledges';
  static String AddPledge = '/pledges';
  static String UpdatePledge(int id) => '/pledges/$id';
  static String DeletePledge(int id) => '/pledges/$id';
  static String UpdateStatusPledges(int id) => '/pledges/$id/status';
}
