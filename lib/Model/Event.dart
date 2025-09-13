<<<<<<< HEAD
import 'package:impactlyflutter/Model/Category.dart';
import 'package:impactlyflutter/Model/Pledges.dart';

=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
class Event {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? location;
  String? category;
  int? maxVolunteers;
  int? creatorId;
  int? districtId;
  String? status;
  var rejectionReason;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  int? volunteerRegistrationsCount;
  String? districtName;
  String? governorateName;
  String? organizerName;
  bool? isRegistered;
  int? registrationId;
<<<<<<< HEAD
  List<Pledges>? requestedPledges;
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836

  Event({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.category,
    this.maxVolunteers,
    this.creatorId,
    this.districtId,
    this.status,
    this.rejectionReason,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.volunteerRegistrationsCount,
    this.districtName,
    this.governorateName,
    this.organizerName,
    this.isRegistered,
    this.registrationId,
<<<<<<< HEAD
    this.requestedPledges,
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    location = json['location'];
    category = json['category'];
    maxVolunteers = json['max_volunteers'];
    creatorId = json['creator_id'];
    districtId = json['district_id'];
    status = json['status'];
    rejectionReason = json['rejection_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];

    if (json.containsKey('volunteer_registrations_count')) {
      volunteerRegistrationsCount = json['volunteer_registrations_count'];
    }
    if (json.containsKey('district_name')) {
      districtName = json['district_name'];
    }
    if (json.containsKey('governorate_name')) {
      governorateName = json['governorate_name'];
    }
    if (json.containsKey('organizer_name')) {
      organizerName = json['organizer_name'];
    }
    if (json.containsKey('is_registered')) {
      isRegistered = json['is_registered'] == true;
    } else {
      isRegistered = false;
    }
    if (json.containsKey('registration_id')) {
      registrationId = json['registration_id'];
    }
<<<<<<< HEAD
    if (json['requested_pledges'] != null) {
      requestedPledges = <Pledges>[];
      json['requested_pledges'].forEach((v) {
        requestedPledges!.add(new Pledges.fromJson(v));
      });
    }
  }

  Event.fromJsonPledge(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    location = json['location'];
    category =
        json['category'] != null
            ? Category.fromJson(json['category']).name
            : null;
    maxVolunteers = json['max_volunteers'];
    creatorId = json['creator_id'];
    districtId = json['district_id'];
    status = json['status'];
    rejectionReason = json['rejection_reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];

    if (json.containsKey('volunteer_registrations_count')) {
      volunteerRegistrationsCount = json['volunteer_registrations_count'];
    }
    if (json.containsKey('district_name')) {
      districtName = json['district_name'];
    }
    if (json.containsKey('governorate_name')) {
      governorateName = json['governorate_name'];
    }
    if (json.containsKey('organizer_name')) {
      organizerName = json['organizer_name'];
    }
    if (json.containsKey('is_registered')) {
      isRegistered = json['is_registered'] == true;
    } else {
      isRegistered = false;
    }
    if (json.containsKey('registration_id')) {
      registrationId = json['registration_id'];
    }
    if (json['requested_pledges'] != null) {
      requestedPledges = <Pledges>[];
      json['requested_pledges'].forEach((v) {
        requestedPledges!.add(new Pledges.fromJson(v));
      });
    }
=======
>>>>>>> 825b2bb55dfeb431a16107c04ddf047000640836
  }
}
