import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../utils/extensions/dio_client.dart';
import '../model/asset.dart';
import '../model/asset_details.dart';
import 'asset_api.dart';

class AssetRepo {
  // static Future<DataState<List<Asset>>> getAssets() async {
  //   try {
  //     final response = await AssetApiService(dioManager: DioManager.instance).getAssets();
  //     if (response.statusCode == HttpStatus.ok) {
  //       final Map<String, dynamic> jsonResponse = response.data;
  //       final List<dynamic> result = jsonResponse["result"];
  //       final List<Asset> assets = result.map((json) => Asset.fromJson(json)).toList();
  //       return DataSuccess(assets);
  //     } else {
  //       return DataFailed(
  //         DioException(
  //             error: response.response.statusMessage,
  //             response: response.response,
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.response.requestOptions),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return DataFailed(e);
  //   }
  // }
  //
  // static Future<DataState<AssetDetails>> getAssetsById(String assetId) async {
  //   try {
  //     final response =
  //         await AssetApiService(dioManager: DioManager.instance).getAssetsById(assetId);
  //     if (response.statusCode == HttpStatus.ok) {
  //       final Map<String, dynamic> jsonResponse = response.data;
  //
  //       final AssetDetails asset = AssetDetails.fromJson(jsonResponse);
  //
  //       return DataSuccess(asset);
  //     } else {
  //       return DataFailed(
  //         DioException(
  //             error: response.response.statusMessage,
  //             response: response.response,
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.response.requestOptions),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return DataFailed(e);
  //   }
  // }
  //
  //
  // static Future<DataState<List<AssetPartsModel>>> getAssetsPartsById(String assetId) async {
  //   try {
  //     final response =
  //     await AssetApiService(dioManager: DioManager.instance).getAssetPartsById(assetId);
  //     if (response.statusCode == HttpStatus.ok) {
  //       final Map<String, dynamic> jsonResponse = response.data;
  //       List<AssetPartsModel> assetParts = [];
  //
  //       if(jsonResponse["message"] != ""){
  //         final Map<String, dynamic> body = jsonDecode(response.data);
  //         List<dynamic> results = body["result"];
  //          assetParts = results.map((json) => AssetPartsModel.fromJson(json)).toList();
  //          print(assetParts.length);
  //          return DataSuccess(assetParts);
  //       }else{
  //         return DataSuccess(assetParts);
  //       }
  //     } else {
  //       return DataFailed(
  //         DioException(
  //             error: response.response.statusMessage,
  //             response: response.response,
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.response.requestOptions),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return DataFailed(e);
  //   }
  // }
  //
  //
  //
  // static Future<DataState<AssetDetails>> getSpecifyById(String assetId) async {
  //   try {
  //     final response =
  //     await AssetApiService(dioManager: DioManager.instance).getSpecifyById(assetId);
  //     if (response.statusCode == HttpStatus.ok) {
  //       final Map<String, dynamic> jsonResponse = response.data;
  //
  //       final AssetDetails asset = AssetDetails.fromJson(jsonResponse);
  //
  //       return DataSuccess(asset);
  //     } else {
  //       return DataFailed(
  //         DioException(
  //             error: response.response.statusMessage,
  //             response: response.response,
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.response.requestOptions),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return DataFailed(e);
  //   }
  // }
  //

}
