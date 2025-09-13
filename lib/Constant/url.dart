// import 'package:impactlyflutter/View/EventDetails/EventDetails.dart';

class AppApi {
<<<<<<< HEAD
  static String url = "http://192.168.223.64:8000/api";
  static String urlimage = "http://192.168.223.64:8000/Storage";
=======
  static String url = "http://10.0.2.2:8000/api";
  static String urlimage = "http://10.0.2.2:8000/Storage";
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

  //Auth
  static String LOGIN = '/login';
  static String REGISTER = '/register';
  static String GOVERNORATES = '/governorates';
<<<<<<< HEAD
  static String CATEGORIES = '/categories';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  static String DistrictEvents = '/district-events';
  static String GetProfile = '/profile';
  static String UpdateProfile = '/profile';

  ///////////////////
  static String GetMyEvent = '/my-events';
  static String AddEvent = '/events';
<<<<<<< HEAD
  static String AllEvents = '/allevents';
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
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
<<<<<<< HEAD
  ///////////////////
  static String AddReport = '/reports';
  static String MyReports = '/my-reports';
  static String LateReport(int id) => '/events/$id/delay-report';
  //////////////////
  static String AddRequestedPledge = "/organizer/pledges";
  static String UpdateRequestedPledge(int id) => "/organizer/pledges/$id";
  static String DeleteRequestedPledge(int id) => "/organizer/pledges/$id";
  static String GetEventRequests(int eventId) =>
      "/organizer/events/$eventId/requests";
  //////////////////
  static String GetWallet = "/wallet";
  //////////////////
  static String Notifications = "/notifications";
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
}
