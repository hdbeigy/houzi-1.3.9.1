import 'package:dio/dio.dart';
import 'package:jakojast/models/api/api_response.dart';
import 'package:jakojast/models/article.dart';
import 'package:jakojast/models/partner.dart';
import 'package:jakojast/models/property_meta_data.dart';
import 'package:jakojast/models/realtor_model.dart';
import 'package:jakojast/models/saved_search.dart';
import 'package:jakojast/models/user.dart';
import 'package:jakojast/models/user_membership_package.dart';

abstract class ApiParserInterface {
  Article parseArticle(Map<String, dynamic> json);
  Term parseMetaDataMap(Map<String, dynamic> json);
  Agent parseAgentInfo(Map<String, dynamic> json);
  Agency parseAgencyInfo(Map<String, dynamic> json);
  SavedSearch parseSavedSearch(Map<String, dynamic> json);
  User parseUserInfo(Map<String, dynamic> json);
  ApiResponse<String> parseNonceResponse(Response response);
  Partner parsePartnerJson(Map<String, dynamic> json);
  ApiResponse<String> parsePaymentResponse(Response response);
  ApiResponse<String> parseNormalApiResponse(Response response);
  ApiResponse<String> parseFeaturedResponse(Response response);
  ApiResponse<String> parse500ApiResponse(Response response);
  UserMembershipPackage parseUserMembershipPackageResponse(Map<String, dynamic> json);
}