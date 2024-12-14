class HttpUrl {
  //api.dealerpro.in
  static const String baseUrl = 'https://demoapi.orienseam.com/';
  static const String generateOtp = '${baseUrl}api/generate-otp';
  static const String verifyOtp = '${baseUrl}api/verify-otp';
  static const String loginUrl = '${baseUrl}api/users/signin';
  static const String forgotPassword = '${baseUrl}api/users/forgotpassword';
  static const String getVehicle = '${baseUrl}api/mobile/invoice/';
  static const String getVehicleDetails = '${baseUrl}api/mobile/vehicle/';
  static const String getWarranty = '${baseUrl}api/mobile/warranty/';
  static const String getService = '${baseUrl}api/mobile/service/';
  static const String getSpareDetails = '${baseUrl}api/mobile/spare/';
  static const String getAccessoryDetails = '${baseUrl}api/mobile/accessory/';
  static const String getProfileDetails = '${baseUrl}api/mobile/customer/';
  static const String getBookServiceCustomer = '${baseUrl}api/bookservices/customer/';
  static const String ServiceBooking = '${baseUrl}api/bookservices';



  static const String getAllAssets = '${baseUrl}api/assets/getall';
  static const String getAllLocations = '${baseUrl}api/location/getall';
  static const String getAllProblems = '${baseUrl}api/problems/getall/';
  static const String assetPartsById = '${baseUrl}api/assetparts/partsbyassetid/';
  static const String specifyById = '${baseUrl}api/assettechspec/getbyassetid/';
  static const String assetById = '${baseUrl}api/assets/getbyid/';




}
