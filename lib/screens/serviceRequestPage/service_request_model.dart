import 'dart:convert';

ServiceRequest serviceRequestFromJson(String str) => ServiceRequest.fromJson(json.decode(str));

String serviceRequestToJson(ServiceRequest data) => json.encode(data.toJson());

class ServiceRequest {
  final String? assetName;
  final String? locationName;
  final String? failureClassName;
  final String? problemName;
  final String? failureCodetype;
  final String? serviceRequestName;
  final String? code;
  final String? description;
  final String? reasontoCancel;
  final String? workType;
  final String? status;
  final String? failureClassId;
  final String? problemId;
  final DateTime? requestedDate;
  final DateTime? stopBeginDate;
  final DateTime? closingDate;
  final DateTime? approvalDate;
  final String? assetId;
  final String? locationId;
  final bool? isWoCreated;
  final String? id;
  final bool? isActive;
  final bool? isDeleted;
  final DateTime? createdDate;

  ServiceRequest({
    this.assetName,
    this.locationName,
    this.failureClassName,
    this.problemName,
    this.failureCodetype,
    this.serviceRequestName,
    this.code,
    this.description,
    this.reasontoCancel,
    this.workType,
    this.status,
    this.failureClassId,
    this.problemId,
    this.requestedDate,
    this.stopBeginDate,
    this.closingDate,
    this.approvalDate,
    this.assetId,
    this.locationId,
    this.isWoCreated,
    this.id,
    this.isActive,
    this.isDeleted,
    this.createdDate,
  });

  ServiceRequest copyWith({
    String? assetName,
    String? locationName,
    String? failureClassName,
    String? problemName,
    String? failureCodetype,
    String? serviceRequestName,
    String? code,
    String? description,
    String? reasontoCancel,
    String? workType,
    String? status,
    String? failureClassId,
    String? problemId,
    DateTime? requestedDate,
    DateTime? stopBeginDate,
    DateTime? closingDate,
    DateTime? approvalDate,
    String? assetId,
    String? locationId,
    bool? isWoCreated,
    String? id,
    bool? isActive,
    bool? isDeleted,
    DateTime? createdDate,
  }) =>
      ServiceRequest(
        assetName: assetName ?? this.assetName,
        locationName: locationName ?? this.locationName,
        failureClassName: failureClassName ?? this.failureClassName,
        problemName: problemName ?? this.problemName,
        failureCodetype: failureCodetype ?? this.failureCodetype,
        serviceRequestName: serviceRequestName ?? this.serviceRequestName,
        code: code ?? this.code,
        description: description ?? this.description,
        reasontoCancel: reasontoCancel ?? this.reasontoCancel,
        workType: workType ?? this.workType,
        status: status ?? this.status,
        failureClassId: failureClassId ?? this.failureClassId,
        problemId: problemId ?? this.problemId,
        requestedDate: requestedDate ?? this.requestedDate,
        stopBeginDate: stopBeginDate ?? this.stopBeginDate,
        closingDate: closingDate ?? this.closingDate,
        approvalDate: approvalDate ?? this.approvalDate,
        assetId: assetId ?? this.assetId,
        locationId: locationId ?? this.locationId,
        isWoCreated: isWoCreated ?? this.isWoCreated,
        id: id ?? this.id,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdDate: createdDate ?? this.createdDate,
      );

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
    assetName: json["assetName"],
    locationName: json["locationName"],
    failureClassName: json["failureClassName"],
    problemName: json["problemName"],
    failureCodetype: json["failureCodetype"],
    serviceRequestName: json["serviceRequestName"],
    code: json["code"],
    description: json["description"],
    reasontoCancel: json["reasontoCancel"],
    workType: json["workType"],
    status: json["status"],
    failureClassId: json["failureClassId"],
    problemId: json["problemId"],
    requestedDate: json["requestedDate"] == null ? null : DateTime.parse(json["requestedDate"]),
    stopBeginDate: json["stopBeginDate"] == null ? null : DateTime.parse(json["stopBeginDate"]),
    closingDate: json["closingDate"] == null ? null : DateTime.parse(json["closingDate"]),
    approvalDate: json["approvalDate"] == null ? null : DateTime.parse(json["approvalDate"]),
    assetId: json["assetId"],
    locationId: json["locationId"],
    isWoCreated: json["isWoCreated"],
    id: json["id"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "assetName": assetName,
    "locationName": locationName,
    "failureClassName": failureClassName,
    "problemName": problemName,
    "failureCodetype": failureCodetype,
    "serviceRequestName": serviceRequestName,
    "code": code,
    "description": description,
    "reasontoCancel": reasontoCancel,
    "workType": workType,
    "status": status,
    "failureClassId": failureClassId,
    "problemId": problemId,
    "requestedDate": requestedDate?.toIso8601String(),
    "stopBeginDate": stopBeginDate?.toIso8601String(),
    "closingDate": closingDate?.toIso8601String(),
    "approvalDate": approvalDate?.toIso8601String(),
    "assetId": assetId,
    "locationId": locationId,
    "isWoCreated": isWoCreated,
    "id": id,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdDate": DateTime.now(),
  };
}

