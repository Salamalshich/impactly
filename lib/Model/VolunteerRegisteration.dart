import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/Registeration.dart';
<<<<<<< HEAD
import 'package:impactlyflutter/Model/VolunteerParticipation.dart';

class VolunteerRegisteration {
  Registration? registration;
  List<VolunteerParticipation>? volunteerParticipations;
  Event? event;

  VolunteerRegisteration({
    this.registration,
    this.volunteerParticipations,
    this.event,
  });
=======

class VolunteerRegisteration {
  Registration? registration;
  Event? event;

  VolunteerRegisteration({this.registration, this.event});
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

  VolunteerRegisteration.fromJson(Map<String, dynamic> json) {
    registration =
        json['registration'] != null
            ? new Registration.fromJson(json['registration'])
            : null;
<<<<<<< HEAD
    if (json['volunteer_participations'] != null) {
      volunteerParticipations = <VolunteerParticipation>[];
      json['volunteer_participations'].forEach((v) {
        volunteerParticipations!.add(VolunteerParticipation.fromJson(v));
      });
    }
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }
}
