import 'package:impactlyflutter/Model/Event.dart';
import 'package:impactlyflutter/Model/Pledges.dart';
import 'package:impactlyflutter/Model/VolunteerParticipation.dart';

class EventDetails {
  Event? event;
  List<VolunteerParticipation>? volunteerParticipations;
  List<Pledges>? pledges;

  EventDetails({this.event, this.volunteerParticipations, this.pledges});

  EventDetails.fromJson(Map<String, dynamic> json) {
    event = Event.fromJson(json);

    if (json['volunteer_participations'] != null) {
      volunteerParticipations = <VolunteerParticipation>[];
      json['volunteer_participations'].forEach((v) {
        volunteerParticipations!.add(VolunteerParticipation.fromJson(v));
      });
    }

    if (json['pledges'] != null) {
      pledges = <Pledges>[];
      json['pledges'].forEach((v) {
        pledges!.add(Pledges.fromJson(v));
      });
    }
  }
}
