import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/Registeration.dart';

class VolunteerRegisteration {
  Registration? registration;
  Event? event;

  VolunteerRegisteration({this.registration, this.event});

  VolunteerRegisteration.fromJson(Map<String, dynamic> json) {
    registration =
        json['registration'] != null
            ? new Registration.fromJson(json['registration'])
            : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }
}
