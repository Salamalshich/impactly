import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/Registeration.dart';
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

  VolunteerRegisteration.fromJson(Map<String, dynamic> json) {
    registration =
        json['registration'] != null
            ? new Registration.fromJson(json['registration'])
            : null;
    if (json['volunteer_participations'] != null) {
      volunteerParticipations = <VolunteerParticipation>[];
      json['volunteer_participations'].forEach((v) {
        volunteerParticipations!.add(VolunteerParticipation.fromJson(v));
      });
    }
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }
}
