import 'package:dio/dio.dart';
import '../../../http/httpurls.dart';
import '../../../utils/extensions/dio_client.dart';

class AssetApiService {
  final DioManager dioManager;

  AssetApiService({required this.dioManager});

  Future<dynamic> getAssets() async {
    Response response = await dioManager.dio.get(HttpUrl.getAllAssets);
    return response;
  }

  Future<dynamic> getAssetsById(String assetId) async {
    print(HttpUrl.assetById + assetId);
    Response response = await dioManager.dio.get(HttpUrl.assetById + assetId);
    return response;
  }

  Future<dynamic> getSpecifyById(String assetId) async {
    print(HttpUrl.specifyById + assetId);
    Response response = await dioManager.dio.get(HttpUrl.specifyById + assetId);
    return response;
  }

  Future<dynamic> getAssetPartsById(String assetId) async {
    print(HttpUrl.assetPartsById + assetId);
    Response response = await dioManager.dio.get(HttpUrl.assetPartsById + assetId);
    return response;
  }
}
