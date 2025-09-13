import 'package:impactlyflutter/Model/Reportable.dart';

class Reports {
  int? id;
  int? reporterId;
  String? reportableType;
  int? reportableId;
  String? reason;
  String? status;
  var resolution;
  var resolvedBy;
  String? createdAt;
  String? updatedAt;
  Reportable? reportable;

  Reports({
    this.id,
    this.reporterId,
    this.reportableType,
    this.reportableId,
    this.reason,
    this.status,
    this.resolution,
    this.resolvedBy,
    this.createdAt,
    this.updatedAt,
    this.reportable,
  });

  Reports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reporterId = json['reporter_id'];
    reportableType =
        json['reportable_type'] == "App\\Models\\Event" ? "Event" : "User";
    reportableId = json['reportable_id'];
    reason = json['reason'];
    status = json['status'];
    resolution = json['resolution'];
    resolvedBy = json['resolved_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reportable =
        json['reportable'] != null
            ? new Reportable.fromJson(json['reportable'])
            : null;
  }
}
