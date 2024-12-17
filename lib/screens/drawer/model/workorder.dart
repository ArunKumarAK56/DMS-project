// To parse this JSON data, do
//
//     final workOrder = workOrderFromJson(jsonString);

import 'dart:convert';

WorkOrder workOrderFromJson(String str) => WorkOrder.fromJson(json.decode(str));

String workOrderToJson(WorkOrder data) => json.encode(data.toJson());

class WorkOrder {
  List<Result> result;
  String message;
  int statusCode;

  WorkOrder({
    required this.result,
    required this.message,
    required this.statusCode,
  });

  factory WorkOrder.fromJson(Map<String, dynamic> json) => WorkOrder(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "statusCode": statusCode,
  };
}

class Result {
  String locationCode;
  PriorityName priorityName;
  PriorityColour priorityColour;
  double duration;
  String assetName;
  String assetCode;
  JobPlanName jobPlanName;
  WorkTypeName? workTypeName;
  FailureClassName failureClassName;
  ProblemName problemName;
  String locationName;
  String serviceRequestName;
  String serviceRequestCode;
  String preventiveMaintenanceName;
  String pmCode;
  String approvedByName;
  ResponsiblePersonName responsiblePersonName;
  String rejectedByName;
  String? preventiveMaintenanceId;
  String workOrderName;
  String description;
  String? jobPlanId;
  String jobNo;
  String assetId;
  String locationId;
  bool isFavouriteWo;
  double workedHours;
  String? workTypeId;
  Status status;
  double currentReading;
  DateTime? targetStartDate;
  DateTime? targetEndDate;
  DateTime? plannedStartDate;
  DateTime? plannedEndDate;
  DateTime? stopBeginDate;
  String id;
  String code;
  bool isActive;
  bool isDeleted;
  String siteId;
  DateTime createdDate;
  DateTime? earliestStartDate;
  DateTime? latestEndDate;
  String? serviceRequestId;
  DateTime? actualStartDate;
  DateTime? actualEndDate;
  String? notes;
  DateTime? stopEndDate;
  String? failureClassId;
  String? problemId;
  String? priorityId;
  String? responsiblePersonId;
  String? reasonToCancel;

  Result({
    required this.locationCode,
    required this.priorityName,
    required this.priorityColour,
    required this.duration,
    required this.assetName,
    required this.assetCode,
    required this.jobPlanName,
    this.workTypeName,
    required this.failureClassName,
    required this.problemName,
    required this.locationName,
    required this.serviceRequestName,
    required this.serviceRequestCode,
    required this.preventiveMaintenanceName,
    required this.pmCode,
    required this.approvedByName,
    required this.responsiblePersonName,
    required this.rejectedByName,
    this.preventiveMaintenanceId,
    required this.workOrderName,
    required this.description,
    this.jobPlanId,
    required this.jobNo,
    required this.assetId,
    required this.locationId,
    required this.isFavouriteWo,
    required this.workedHours,
    this.workTypeId,
    required this.status,
    required this.currentReading,
    this.targetStartDate,
    this.targetEndDate,
    this.plannedStartDate,
    this.plannedEndDate,
    this.stopBeginDate,
    required this.id,
    required this.code,
    required this.isActive,
    required this.isDeleted,
    required this.siteId,
    required this.createdDate,
    this.earliestStartDate,
    this.latestEndDate,
    this.serviceRequestId,
    this.actualStartDate,
    this.actualEndDate,
    this.notes,
    this.stopEndDate,
    this.failureClassId,
    this.problemId,
    this.priorityId,
    this.responsiblePersonId,
    this.reasonToCancel,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    locationCode: json["locationCode"],
    priorityName: priorityNameValues.map[json["priorityName"]]!,
    priorityColour: priorityColourValues.map[json["priorityColour"]]!,
    duration: json["duration"]?.toDouble(),
    assetName: json["assetName"],
    assetCode: json["assetCode"],
    jobPlanName: jobPlanNameValues.map[json["jobPlanName"]]!,
    workTypeName: workTypeNameValues.map[json["workTypeName"]],
    failureClassName: failureClassNameValues.map[json["failureClassName"]]!,
    problemName: problemNameValues.map[json["problemName"]]!,
    locationName: json["locationName"],
    serviceRequestName: json["serviceRequestName"],
    serviceRequestCode: json["serviceRequestCode"],
    preventiveMaintenanceName: json["preventiveMaintenanceName"],
    pmCode: json["pmCode"],
    approvedByName: json["approvedByName"],
    responsiblePersonName: responsiblePersonNameValues.map[json["responsiblePersonName"]]!,
    rejectedByName: json["rejectedByName"],
    preventiveMaintenanceId: json["preventiveMaintenanceId"],
    workOrderName: json["workOrderName"],
    description: json["description"],
    jobPlanId: json["jobPlanId"],
    jobNo: json["jobNo"],
    assetId: json["assetId"],
    locationId: json["locationId"],
    isFavouriteWo: json["isFavouriteWO"],
    workedHours: json["workedHours"]?.toDouble(),
    workTypeId: json["workTypeId"],
    status: statusValues.map[json["status"]]!,
    currentReading: json["currentReading"],
    targetStartDate: json["targetStartDate"] == null ? null : DateTime.parse(json["targetStartDate"]),
    targetEndDate: json["targetEndDate"] == null ? null : DateTime.parse(json["targetEndDate"]),
    plannedStartDate: json["plannedStartDate"] == null ? null : DateTime.parse(json["plannedStartDate"]),
    plannedEndDate: json["plannedEndDate"] == null ? null : DateTime.parse(json["plannedEndDate"]),
    stopBeginDate: json["stopBeginDate"] == null ? null : DateTime.parse(json["stopBeginDate"]),
    id: json["id"],
    code: json["code"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    siteId: json["siteId"],
    createdDate: DateTime.parse(json["createdDate"]),
    earliestStartDate: json["earliestStartDate"] == null ? null : DateTime.parse(json["earliestStartDate"]),
    latestEndDate: json["latestEndDate"] == null ? null : DateTime.parse(json["latestEndDate"]),
    serviceRequestId: json["serviceRequestId"],
    actualStartDate: json["actualStartDate"] == null ? null : DateTime.parse(json["actualStartDate"]),
    actualEndDate: json["actualEndDate"] == null ? null : DateTime.parse(json["actualEndDate"]),
    notes: json["notes"],
    stopEndDate: json["stopEndDate"] == null ? null : DateTime.parse(json["stopEndDate"]),
    failureClassId: json["failureClassId"],
    problemId: json["problemId"],
    priorityId: json["priorityId"],
    responsiblePersonId: json["responsiblePersonId"],
    reasonToCancel: json["reasonToCancel"],
  );

  Map<String, dynamic> toJson() => {
    "locationCode": locationCode,
    "priorityName": priorityNameValues.reverse[priorityName],
    "priorityColour": priorityColourValues.reverse[priorityColour],
    "duration": duration,
    "assetName": assetName,
    "assetCode": assetCode,
    "jobPlanName": jobPlanNameValues.reverse[jobPlanName],
    "workTypeName": workTypeNameValues.reverse[workTypeName],
    "failureClassName": failureClassNameValues.reverse[failureClassName],
    "problemName": problemNameValues.reverse[problemName],
    "locationName": locationName,
    "serviceRequestName": serviceRequestName,
    "serviceRequestCode": serviceRequestCode,
    "preventiveMaintenanceName": preventiveMaintenanceName,
    "pmCode": pmCode,
    "approvedByName": approvedByName,
    "responsiblePersonName": responsiblePersonNameValues.reverse[responsiblePersonName],
    "rejectedByName": rejectedByName,
    "preventiveMaintenanceId": preventiveMaintenanceId,
    "workOrderName": workOrderName,
    "description": description,
    "jobPlanId": jobPlanId,
    "jobNo": jobNo,
    "assetId": assetId,
    "locationId": locationId,
    "isFavouriteWO": isFavouriteWo,
    "workedHours": workedHours,
    "workTypeId": workTypeId,
    "status": statusValues.reverse[status],
    "currentReading": currentReading,
    "targetStartDate": targetStartDate?.toIso8601String(),
    "targetEndDate": targetEndDate?.toIso8601String(),
    "plannedStartDate": plannedStartDate?.toIso8601String(),
    "plannedEndDate": plannedEndDate?.toIso8601String(),
    "stopBeginDate": stopBeginDate?.toIso8601String(),
    "id": id,
    "code": code,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "siteId": siteId,
    "createdDate": createdDate.toIso8601String(),
    "earliestStartDate": earliestStartDate?.toIso8601String(),
    "latestEndDate": latestEndDate?.toIso8601String(),
    "serviceRequestId": serviceRequestId,
    "actualStartDate": actualStartDate?.toIso8601String(),
    "actualEndDate": actualEndDate?.toIso8601String(),
    "notes": notes,
    "stopEndDate": stopEndDate?.toIso8601String(),
    "failureClassId": failureClassId,
    "problemId": problemId,
    "priorityId": priorityId,
    "responsiblePersonId": responsiblePersonId,
    "reasonToCancel": reasonToCancel,
  };
}

enum FailureClassName {
  CAMERA,
  DOSING,
  EMPTY,
  MOULDING,
  TEST_CLASS
}

final failureClassNameValues = EnumValues({
  "Camera": FailureClassName.CAMERA,
  "Dosing": FailureClassName.DOSING,
  "": FailureClassName.EMPTY,
  "Moulding": FailureClassName.MOULDING,
  "Test Class": FailureClassName.TEST_CLASS
});

enum JobPlanName {
  ANNUAL_SERVICE,
  AUTOMATIC_BORING_DOWELLING_MACHINE,
  BELT_CHANGE,
  CHECK_DRIVE_CHAIN,
  CHECK_STARWHEEL,
  EMPTY,
  TEST_40
}

final jobPlanNameValues = EnumValues({
  "Annual service": JobPlanName.ANNUAL_SERVICE,
  "Automatic Boring & Dowelling Machine": JobPlanName.AUTOMATIC_BORING_DOWELLING_MACHINE,
  "Belt change": JobPlanName.BELT_CHANGE,
  "Check drive chain": JobPlanName.CHECK_DRIVE_CHAIN,
  "Check starwheel": JobPlanName.CHECK_STARWHEEL,
  "": JobPlanName.EMPTY,
  "Test_40": JobPlanName.TEST_40
});

enum PriorityColour {
  E50_B0_B,
  EMPTY,
  THE_4_EAF0_E
}

final priorityColourValues = EnumValues({
  "#e50b0b": PriorityColour.E50_B0_B,
  "": PriorityColour.EMPTY,
  "#4eaf0e": PriorityColour.THE_4_EAF0_E
});

enum PriorityName {
  EMERGENCY_WITHIN_24_HRS,
  EMPTY,
  NORMAL_WITHIN_1_WEEK
}

final priorityNameValues = EnumValues({
  "Emergency - Within 24 hrs": PriorityName.EMERGENCY_WITHIN_24_HRS,
  "": PriorityName.EMPTY,
  "Normal - Within 1 Week": PriorityName.NORMAL_WITHIN_1_WEEK
});

enum ProblemName {
  CORROSION_FAILURE,
  EMPTY,
  FRACTURE_FAILURE,
  MECHANICAL,
  PROBLEM2,
  SEAL,
  TEST_PROBLEM,
  TES_PRO_1
}

final problemNameValues = EnumValues({
  "Corrosion failure": ProblemName.CORROSION_FAILURE,
  "": ProblemName.EMPTY,
  "Fracture failure": ProblemName.FRACTURE_FAILURE,
  "Mechanical": ProblemName.MECHANICAL,
  "Problem2": ProblemName.PROBLEM2,
  "Seal": ProblemName.SEAL,
  "Test problem": ProblemName.TEST_PROBLEM,
  "Tes Pro 1": ProblemName.TES_PRO_1
});

enum ResponsiblePersonName {
  BOB_FLYNN,
  DAVID,
  DAVID_JONES,
  EMPTY,
  JOHN_JONES,
  PETER_SMITH,
  THOMAS_ADLER
}

final responsiblePersonNameValues = EnumValues({
  "Bob Flynn": ResponsiblePersonName.BOB_FLYNN,
  "David": ResponsiblePersonName.DAVID,
  "David Jones": ResponsiblePersonName.DAVID_JONES,
  "": ResponsiblePersonName.EMPTY,
  "John Jones": ResponsiblePersonName.JOHN_JONES,
  "Peter Smith": ResponsiblePersonName.PETER_SMITH,
  "Thomas Adler": ResponsiblePersonName.THOMAS_ADLER
});

enum Status {
  CLOSE,
  COMP,
  INPRG,
  NEW
}

final statusValues = EnumValues({
  "CLOSE": Status.CLOSE,
  "COMP": Status.COMP,
  "INPRG": Status.INPRG,
  "NEW": Status.NEW
});

enum WorkTypeName {
  CM,
  EM,
  PM
}

final workTypeNameValues = EnumValues({
  "CM": WorkTypeName.CM,
  "EM": WorkTypeName.EM,
  "PM": WorkTypeName.PM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
