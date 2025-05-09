import 'package:jakojast/common/constants.dart';
import 'package:jakojast/files/hooks_files/hooks_configurations.dart';
import 'package:jakojast/providers/state_providers/locale_provider.dart';
import 'package:jakojast/files/hive_storage_files/hive_storage_manager.dart';
import 'package:jakojast/interfaces/api_parser_interface.dart';
import 'package:jakojast/interfaces/api_provider_interface.dart';
import 'package:jakojast/models/api/api_request.dart';
import 'dart:io' show Platform;

import 'package:jakojast/parsers/houzez_parser.dart';

import '../../utils/platform_helper.dart';



// const String HOUZEZ_ALL_PROPERTIES_PATH = "/wp-json/wp/v2/$REST_API_PROPERTIES_ROUTE";
// آدرس‌های جدید API
String HOUZEZ_ALL_PROPERTIES_PATH = "/api/houzi-api/v1/all-properties";
const String HOUZEZ_NEW_ALL_PROPERTIES_PATH = "/api/houzi-api/v1/all-properties";
const String HOUZEZ_SIMILAR_PROPERTIES_PATH = "/api/houzi-api/v1/similar-properties";
const String HOUZEZ_MULTIPLE_PROPERTIES_PATH = "/api/houzi-api/v1/properties";
const String HOUZEZ_PROPERTY_TYPES_META_DATA_PATH = "/api/houzi-api/v1/property-types";
const String HOUZEZ_PROPERTY_CITIES_META_DATA_PATH = "/api/houzi-api/v1/property-cities";
const String HOUZEZ_SEARCH_PROPERTIES_PATH = "/api/houzi-api/v1/search-properties";
const String HOUZEZ_META_DATA_PATH = "/api/houzi-api/v1/touch-base";
String HOUZEZ_SEARCH_AGENCIES_PATH = "/api/houzi-api/v1/search-agencies";
String HOUZEZ_SEARCH_AGENTS_PATH = "/api/houzi-api/v1/search-agents";
const String HOUZEZ_CONTACT_REALTOR_PATH = "/api/houzi-api/v1/contact-property-agent";
const String HOUZEZ_CONTACT_DEVELOPER_PATH = "/api/houzi-api/v1/contact-developer";
const String HOUZEZ_SCHEDULE_A_TOUR_PATH = "/api/houzi-api/v1/schedule-tour";
const String HOUZEZ_SAVE_PROPERTY_PATH = "/api/houzi-api/v1/save-property";
const String HOUZEZ_SAVE_PROPERTY_IMAGES_PATH = "/api/houzi-api/v1/save-property-image";
const String SIGNIN_USER_PATH = "/api/houzi-api/v1/login";
const String HOUZEZ_SOCIAL_LOGIN_PATH = "/api/houzi-api/v1/social-login";
const String SIGNUP_API_LINK_PATH = "/api/houzi-api/v1/register";
const String FORGET_PASSWORD_API_LINK_PATH = "/api/houzi-api/v1/reset-password";
const String HOUZEZ_SINGLE_PROPERTY_PATH = "/api/houzi-api/v1/property";
const String HOUZEZ_MY_PROPERTIES_PATH = "/api/houzi-api/v1/my-properties";
const String HOUZEZ_USERS_DELETE_PROPERTY_PATH = "/api/houzi-api/v1/delete-property";
const String HOUZEZ_TERM_DATA_PATH = "/api/houzi-api/v1/terms";
const String HOUZEZ_ADD_REMOVE_FROM_FAV_PATH = "/api/houzi-api/v1/favorite-property";
const String HOUZEZ_FAV_PROPERTIES_PATH = "/api/houzi-api/v1/favorite-properties";
const String HOUZEZ_UPDATE_PROPERTY_PATH = "/api/houzi-api/v1/update-property";
const String HOUZEZ_UPDATE_IMAGE_PROPERTY_PATH = "/api/houzi-api/v1/upload-property-image";
const String HOUZEZ_DELETE_PROPERTY_IMAGE_PATH = "/api/houzi-api/v1/delete-property-image";
const String HOUZEZ_ADD_SAVED_SEARCH_PATH = "/api/houzi-api/v1/save-search";
const String HOUZEZ_SAVED_SEARCHES_PATH = "/api/houzi-api/v1/saved-searches";
const String HOUZEZ_LEAD_SAVED_SEARCHES_PATH = "/api/houzi-api/v1/lead-saved-searches";
const String HOUZEZ_DELETE_SAVED_SEARCH_PATH = "/api/houzi-api/v1/delete-saved-search";
const String HOUZEZ_SAVED_SEARCH_ARTICLE_PATH = "/api/houzi-api/v1/view-saved-search";
const String HOUZEZ_ADD_REVIEW_ARTICLE_PATH = "/api/houzi-api/v1/add-review";
const String HOUZEZ_REPORT_CONTENT_PATH = "/api/houzi-api/v1/report-content";
const String HOUZEZ_ARTICLE_REVIEWS_PATH = "/api/houzi-api/v1/property-reviews";
const String HOUZEZ_USER_INFO_PATH = "/api/houzi-api/v1/user-profile";
const String HOUZEZ_UPDATE_USER_PROFILE_PATH = "/api/houzi-api/v1/update-profile";
const String HOUZEZ_UPDATE_USER_PROFILE_IMAGE_PATH = "/api/houzi-api/v1/update-profile-photo";
const String HOUZEZ_FIX_PROFILE_IMAGE_PATH = "/api/houzi-api/v1/fix-profile-pic";
const String HOUZEZ_SEARCH_AGENTS_PROFILE_IMAGE_PATH = "/api/houzi-api/v1/update-profile-photo";
const String HOUZEZ_IS_FAV_PROPERTY = "/api/houzi-api/v1/is-favorite-property";
const String HOUZEZ_UPDATE_USER_PASSWORD_PROPERTY = "/api/houzi-api/v1/update-password";
const String HOUZEZ_DELETE_USER_ACCOUNT_PROPERTY = "/api/houzi-api/v1/delete-account";
const String HOUZEZ_SINGLE_ARTICLE_PERMA_LINK_PATH = "/api/houzi-api/v1/property-by-permalink";
const String HOUZEZ_ADD_REQUEST_PROPERTY_PATH = "/api/houzi-api/v1/add-property-request";
const String HOUZEZ_AGENCY_ALL_AGENTS_PATH = "/api/houzi-api/v1/agency-agents";
const String HOUZEZ_AGENCY_ADD_AGENT_PATH = "/api/houzi-api/v1/add-agent";
const String HOUZEZ_AGENCY_EDIT_AGENT_PATH = "/api/houzi-api/v1/edit-agent";
const String HOUZEZ_AGENCY_DELETE_AGENT_PATH = "/api/houzi-api/v1/delete-agent";
const String HOUZEZ_ADS_PATH = "/api/houzi-api/v1/ads";
const String HOUZEZ_ALL_USERS_PATH = "/api/houzi-api/v1/users";
const String HOUZEZ_USER_PAYMENT_STATUS_PATH = "/api/houzi-api/v1/user-payment-status";
const String HOUZEZ_CREATE_NONCE_PATH = "/api/houzi-api/v1/create-nonce";
const String HOUZEZ_PRINT_PDF_PROPERTY_PATH = "/api/houzi-api/v1/print-property-pdf";
const String HOUZEZ_PARTNER_PATH = "/api/houzi-api/v1/partners";
const String HOUZEZ_MEMBERSHIP_PLAN_PATH = "/api/houzi-api/v1/membership-plans";
const String HOUZEZ_PROCEED_WITH_PAYMENT_PATH = "/api/houzi-api/v1/proceed-payment";
const String HOUZEZ_MAKE_PROPERTY_FEATURED_PATH = "/api/houzi-api/v1/make-property-featured";
const String HOUZEZ_REMOVE_FROM_FEATURED_PATH = "/api/houzi-api/v1/remove-from-featured";
const String HOUZEZ_USER_MEMBERSHIP_CURRENT_PACKAGE_PATH = "/api/houzi-api/v1/user-package";
const String HOUZEZ_APPROVE_DISAPPROVE_PATH = "/api/houzi-api/v1/property-approve";
const String HOUZEZ_TOGGLE_FEATURED_PATH = "/api/houzi-api/v1/toggle-featured";
const String HOUZEZ_SOLD_LISTING_PATH = "/api/houzi-api/v1/mark-as-sold";
const String HOUZEZ_EXPIRE_LISTING_PATH = "/api/houzi-api/v1/expire-listing";
const String HOUZEZ_PENDING_LISTING_PATH = "/api/houzi-api/v1/pending-listing";

class HOUZEZApiProvider implements ApiProviderInterface {

  @override
  ApiParserInterface getParser() {
    return HouzezParser();
  }

  Uri getUri({required String unEncodedPath, Map<String, dynamic>? params}){
    Uri? uri;

    // String authority = WORDPRESS_URL_DOMAIN;
    // String communicationProtocol = WORDPRESS_URL_SCHEME;

    /// For Houzi Only (due to demo configurations)
    String authority = HiveStorageManager.readUrlAuthority() ?? BASE_URL_DOMAIN;
    String communicationProtocol = HiveStorageManager.readCommunicationProtocol() ?? URL_SCHEME;
    String urlScheme = URL_PATH;

    // String option = HiveStorageManager.readLocaleInUrl();
    DefaultLanguageCodeHook defaultLanguageCodeHook = HooksConfigurations.defaultLanguageCode;
    String defaultLanguage = defaultLanguageCodeHook();
    String tempSelectedLanguage = HiveStorageManager.readLanguageSelection() ?? defaultLanguage;

    if (currentSelectedLocaleUrlPosition == changeUrlPath) {
      urlScheme = urlScheme+"/$tempSelectedLanguage";
    } else if (currentSelectedLocaleUrlPosition == defaultLangOnUrlAndSecondaryLangAsDirectory) {
      if (tempSelectedLanguage != defaultLanguage) {
        urlScheme = urlScheme+"/$tempSelectedLanguage";
      }
    } else if (currentSelectedLocaleUrlPosition == changeUrlQueryParameter) {
      params ??= {};
      params["lang"] = tempSelectedLanguage;
    }

    if(urlScheme != null && urlScheme.isNotEmpty){
      unEncodedPath = urlScheme + unEncodedPath;
    }

    Map<String, dynamic> queryParams = {};
    if(params != null && params.isNotEmpty){
      queryParams.addAll(params);
    }

    queryParams['app_version'] = getAppVersion();
    queryParams['houzi_version'] = APP_VERSION;
    queryParams['app_build_number'] = getAppBuildNumber();
    queryParams['app_platform'] = getDevicePlatform();

    if(communicationProtocol == HTTP){
      uri = Uri.http(authority, unEncodedPath, queryParams);
    }else if(communicationProtocol == HTTPS){
      uri = Uri.https(authority, unEncodedPath, queryParams);
    }

    return uri!;
  }

  String getDevicePlatform(){
    String platform = "";
    if (PlatformHelper.isAndroid) {
      platform = "android";
    } else if (PlatformHelper.isIOS) {
      platform = "ios";
    }

    return platform;
  }

  String getAppBuildNumber(){
    String appBuildNumber = "";
    Map appInfoMap = HiveStorageManager.readAppInfo() ?? {};
    if(appInfoMap.isNotEmpty){
      appBuildNumber = appInfoMap[APP_INFO_APP_BUILD_NUMBER];
    }

    return appBuildNumber;
  }

  String getAppVersion(){
    String appVersion = "";
    Map appInfoMap = HiveStorageManager.readAppInfo() ?? {};
    if(appInfoMap.isNotEmpty){
      appVersion = appInfoMap[APP_INFO_APP_VERSION];
    }

    return appVersion;
  }

  @override
  Uri provideFeaturedPropertiesApi(int page) {
    var queryParameters = {
      'fave_featured': "${1}",
      'page': '$page',
      'per_page': '${16}',
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideLatestPropertiesApi(int page) {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_PROPERTIES_PATH,
    );
    return uri;
  }


  @override
  Uri provideFilteredPropertiesApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_PROPERTIES_PATH,
    );
    return uri;
  }

  @override
  Uri provideSimilarPropertiesApi(int propertyId) {
    var queryParameters = {
      'property_id': '$propertyId'
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_SIMILAR_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideMultiplePropertiesApi(String propertiesId) {
    var queryParameters = {
      'include': '$propertiesId'
    };
    var uri = getUri(
        unEncodedPath: "$HOUZEZ_MULTIPLE_PROPERTIES_PATH",
        params: queryParameters
    );
    return uri;
  }

  @override
  Uri provideSinglePropertyApi(int id, {bool forEditing = false}) {
    if (forEditing) {
      var queryParameters = {
        'editing': '$forEditing',
        'id': '$id',
      };
      var uri = getUri(
          unEncodedPath: HOUZEZ_SINGLE_PROPERTY_PATH,
          params: queryParameters);
      return uri;
    } else {
      var queryParameters = {
        'id': '$id',
      };
      var uri = getUri(
          unEncodedPath: HOUZEZ_SINGLE_PROPERTY_PATH,
          params: queryParameters);
      return uri;
    }
  }

  @override
  Uri providePropertyMetaDataApi() {
    var uri = getUri(unEncodedPath: HOUZEZ_META_DATA_PATH);
    return uri;
  }

  @override
  Uri provideSingleAgencyInfoApi(int id) {
    var uri = getUri(
      unEncodedPath: "$HOUZEZ_SEARCH_AGENCIES_PATH/$id",
    );
    return uri;
  }

  @override
  Uri provideSingleAgentInfoApi(int id) {
    var uri = getUri(
      unEncodedPath: "$HOUZEZ_SEARCH_AGENTS_PATH/$id",
    );
    return uri;
  }

  /// Not in use
  @override
  Uri providePropertiesByAgencyApi(int id, int page, int perPage) {
    var queryParameters = {
      "fave_property_agency": "$id",
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  /// Not in use
  @override
  Uri providePropertiesByAgentApi(int id, int page, int perPage) {
    var queryParameters = {
      "fave_agents": "$id",
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideAgencyAgentsInfoApi(int agencyId) {
    var queryParameters = {
      "fave_agent_agencies": "$agencyId",
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_AGENTS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideAllAgentsInfoApi(int page, int perPage) {
    var queryParameters = {
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_AGENTS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideAllAgenciesInfoApi(int page, int perPage) {
    var queryParameters = {
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_AGENCIES_PATH,
      params: queryParameters,
    );
    return uri;
  }
  /// Not in use
  @override
  Uri providePropertiesByTypesApi(int id, int page, int perPage) {
    var queryParameters = {
      "property_type": "$id",
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri providePropertiesInCityApi(int id, int page, int perPage) {
    var queryParameters = {
      "property_city": "$id",
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideContactRealtorApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_CONTACT_REALTOR_PATH,
    );
    return uri;
  }

  @override
  ApiRequest provideLoginApiRequest(Map<String, dynamic> params) {
    var uri = getUri(
      unEncodedPath: SIGNIN_USER_PATH,
    );
    params[kSignInNonceVariable] = params[API_NONCE];
    return ApiRequest(uri, params);
  }
  /// Not in use
  @override
  Uri providePropertiesInCityByTypeApi(int cityId, int typeId, int page, int perPage) {
    var queryParameters = {
      "property_city": "$cityId",
      "property_type": "$typeId",
      'page': '$page',
      'per_page': '$perPage',
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideScheduleATourApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SCHEDULE_A_TOUR_PATH,
    );
    return uri;
  }

  @override
  Uri provideSavePropertyApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SAVE_PROPERTY_PATH,
    );
    return uri;
  }

  @override
  Uri provideSavePropertyImagesApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SAVE_PROPERTY_IMAGES_PATH,
    );
    return uri;
  }

  @override
  Uri provideSignUpApi() {
    var uri = getUri(
      unEncodedPath: SIGNUP_API_LINK_PATH,
    );
    return uri;
  }

  @override
  Uri provideStatusOfPropertyApi(int id) {
    var uri = getUri(
      unEncodedPath: '$HOUZEZ_ALL_PROPERTIES_PATH/$id',
    );
    return uri;
  }

  @override
  Uri provideDeletePropertyApi(int id) {
    var queryParameters = {
      'prop_id': "$id",
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_USERS_DELETE_PROPERTY_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideMyPropertiesApi(String status, int page, int perPage, int userId) {
    var queryParameters = {
      'page': "$page",
      'per_page': "$perPage",
      'status': status,

    };
    //'author': "$userId",
    var uri = getUri(
      unEncodedPath: HOUZEZ_MY_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideAllPropertiesApi(String status, int page, int perPage, int? userId) {
    var queryParameters = {
      'page': "$page",
      'per_page': "$perPage",
      'status': status,
      // 'author': "$userId",
    };
    if (userId != null) {
      queryParameters["author"] = "$userId";
    }
    var uri = getUri(
      unEncodedPath: HOUZEZ_NEW_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideForgetPasswordApi() {
    var uri = getUri(
      unEncodedPath: FORGET_PASSWORD_API_LINK_PATH,
    );
    return uri;
  }

  @override
  Uri provideContactDeveloperApi() {
    // var uri = getUri(
    //   unEncodedPath: HOUZEZ_CONTACT_DEVELOPER_PATH,
    // );
    var uri = getUri(
      unEncodedPath: HOUZEZ_CONTACT_DEVELOPER_PATH,
    );
    return uri;
  }

  @override
  Uri provideTermDataApi(dynamic termData) {
    Map<String, dynamic> queryParameters = {};
    if(termData is String){
      queryParameters = {
        'term': termData,
      };
    }else if (termData is List){
      queryParameters = {
        'term[]': termData,
      };
    }
    // print("queryParameters: $queryParameters");

    var uri = getUri(
      unEncodedPath: HOUZEZ_TERM_DATA_PATH,
      params: queryParameters,
    );

    return uri;
  }

  @override
  Uri provideAddOrRemoveFromFavApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_ADD_REMOVE_FROM_FAV_PATH,
    );
    return uri;
  }

  @override
  Uri provideFavPropertiesApi(int page, int perPage,userIdStr) {
    var queryParameters = {
      'post_author': userIdStr,
      'cpage': "$page",
      'per_page': "$perPage",
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_FAV_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideUpdatePropertyApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_UPDATE_PROPERTY_PATH,
    );
    return uri;
  }

  @override
  Uri provideImagesForUpdateArticleApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_UPDATE_IMAGE_PROPERTY_PATH,
    );
    return uri;
  }

  @override
  Uri provideLatLongArticlesApi(String lat, String long) {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_PROPERTIES_PATH,
    );
    return uri;
  }

  @override
  Uri provideDeleteImageFromEditPropertyApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_DELETE_PROPERTY_IMAGE_PATH,
    );
    return uri;
  }

  @override
  Uri provideAddSavedSearchApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_ADD_SAVED_SEARCH_PATH,
    );
    return uri;
  }

  @override
  Uri provideSavedSearches(
    int page,
    int perPage, {
    String? leadId,
    bool fetchLeadSavedSearches = false,
  }) {
    Map<String, dynamic> queryParameters = {};
    if (fetchLeadSavedSearches && leadId != null && leadId.isNotEmpty) {
      queryParameters["lead-id"] = leadId;
      queryParameters["cpage"] = "$page";
    } else {
      queryParameters["per_page"] = "$perPage";
      queryParameters["cpage"] = "$page";
    }

    var uri = getUri(
      unEncodedPath: fetchLeadSavedSearches
          ? HOUZEZ_LEAD_SAVED_SEARCHES_PATH
          : HOUZEZ_SAVED_SEARCHES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideDeleteSavedSearchApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_DELETE_SAVED_SEARCH_PATH,
    );
    return uri;
  }

  @override
  Uri provideSavedSearchArticlesApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SAVED_SEARCH_ARTICLE_PATH,
    );
    return uri;
  }

  @override
  Uri provideAddReviewApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_ADD_REVIEW_ARTICLE_PATH,
    );
    return uri;
  }
  @override
  Uri provideReportContentApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_REPORT_CONTENT_PATH,
    );
    return uri;
  }


  @override
  Uri provideArticlesReviewsApi(int id, String page, String perPage) {
    var queryParameters = {
      'review_property_id': "$id",
      'per_page': perPage,
      'page': page,
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_ARTICLE_REVIEWS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideAgentAgencyAuthorReviewsApi(
      int id, String page, String perPage, String type) {
    String realtorId = "";
    if (type == USER_ROLE_HOUZEZ_AGENT_VALUE) {
      realtorId = "review_agent_id";
    } else if (type == USER_ROLE_HOUZEZ_AGENCY_VALUE) {
      realtorId = "review_agency_id";
    } else {
      realtorId = "review_author_id";
    }
    var queryParameters = {
      realtorId: "$id",
      'per_page': perPage,
      'page': page,
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_ARTICLE_REVIEWS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideUserInfoApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_USER_INFO_PATH,
    );
    return uri;
  }

  @override
  Uri provideUpdateUserProfileApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_UPDATE_USER_PROFILE_PATH,
    );
    return uri;
  }

  @override
  Uri provideUpdateUserProfileImageApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_UPDATE_USER_PROFILE_IMAGE_PATH,
    );
    return uri;
  }

  @override
  Uri provideSearchAgenciesApi(int page, int perPage, String search,) {
    var queryParameters = {
      'search': search,
      'per_page': "$perPage",
      'page': "$page",
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_AGENCIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideSearchAgentsApi(int page, int perPage, String search, String agentCity, String agentCategory) {
    var queryParameters = {
      'search': search,
      'per_page': "$perPage",
      'page': "$page",
    };
    if(agentCity !=null && agentCity.isNotEmpty){
      queryParameters["agent_city"] = agentCity;
    }
    if(agentCategory !=null && agentCategory.isNotEmpty){
      queryParameters["agent_category"] = agentCategory;
    }
    var uri = getUri(
      unEncodedPath: HOUZEZ_SEARCH_AGENTS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideFixProfileImageResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_FIX_PROFILE_IMAGE_PATH,
    );
    return uri;
  }

  @override
  Uri provideIsFavPropertyAp(String listingId) {
    var queryParameters = {
      'listing_id': listingId,
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_IS_FAV_PROPERTY,
      params: queryParameters,
    );
    return uri;
  }

  @override
  ApiRequest provideSocialLoginApi(Map<String, dynamic> params) {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SOCIAL_LOGIN_PATH,
    );
    params[kSignInNonceVariable] = params[API_NONCE];
    return ApiRequest(uri, params);
  }

  /// Not in use
  @override
  Uri providePropertiesByTypeApi(int page, int id, String type) {
    var queryParameters = {
      type: "$id",
      'page': '$page',
      'per_page': '${16}',
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_PROPERTIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideRealtorInfoApi(int page, String type) {
    var queryParameters = {
      'page': '$page',
      'per_page': '${16}',
    };
    var uri = getUri(
      unEncodedPath: type == REST_API_AGENT_ROUTE ? HOUZEZ_SEARCH_AGENTS_PATH : HOUZEZ_SEARCH_AGENCIES_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideDeleteUserAccountApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_DELETE_USER_ACCOUNT_PROPERTY,
    );
    return uri;
  }

  @override
  Uri provideUpdateUserPasswordApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_UPDATE_USER_PASSWORD_PROPERTY,
    );
    return uri;
  }

  @override
  Uri provideSingleArticleViaPermaLinkApi(String permaLink) {
    var queryParameters = {
      "perm": permaLink
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_SINGLE_ARTICLE_PERMA_LINK_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideAddRequestPropertyApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_ADD_REQUEST_PROPERTY_PATH,
    );
    return uri;
  }

  @override
  Uri providePropertiesAdsResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_ADS_PATH,
    );
    return uri;
  }

  @override
  Uri provideAddAgentResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_AGENCY_ADD_AGENT_PATH,
    );
    return uri;
  }

  @override
  Uri provideAgencyAllAgentListApi(int agencyId) {
    var queryParameters = {
      "agency_id": "$agencyId",
    };
    var uri = getUri(
      unEncodedPath: HOUZEZ_AGENCY_ALL_AGENTS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideEditAgentResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_AGENCY_EDIT_AGENT_PATH,
    );
    return uri;
  }

  @override
  provideDeleteAgentResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_AGENCY_DELETE_AGENT_PATH,
    );
    return uri;
  }

  @override
  Uri provideUsersResponseApi(int page, int perPage, String search) {
    var queryParameters = {
      'search': search,
      'per_page': "$perPage",
      'page': "$page",
    };

    var uri = getUri(
      unEncodedPath: HOUZEZ_ALL_USERS_PATH,
      params: queryParameters,
    );
    return uri;
  }

  @override
  Uri provideUserPaymentStatusResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_USER_PAYMENT_STATUS_PATH,
    );
    return uri;
  }

  @override
  Uri provideCreateNonceApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_CREATE_NONCE_PATH,
    );
    return uri;
  }

  @override
  Uri providePrintPdfPropertyApi(Map<String, dynamic> dataMap) {
    var uri = getUri(
      unEncodedPath: HOUZEZ_PRINT_PDF_PROPERTY_PATH,
      params: dataMap
    );
    return uri;
  }

  @override
  Uri providePartnersListApi() {
    var uri = getUri(unEncodedPath: HOUZEZ_PARTNER_PATH);
    return uri;
  }

  Uri provideMembershipPackagesApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_MEMBERSHIP_PLAN_PATH,
      params: {PER_PAGE_KEY : "$PER_PAGE_VALUE"});
    return uri;
  }

  @override
  Uri provideDirectionsApi(String platform, String latitude, String longitude) {
    String url = "";

    if (platform == PLATFORM_APPLE_MAPS) {
      url = "https://maps.apple.com/?daddr=$latitude,$longitude"
          "&dirflg=d";
    } else {
      url = "https://www.google.com/maps/dir/?api=1"
          "&destination=$latitude,$longitude"
          "&mode=driving";
      // "&dir_action=navigate"; // for starting navigation
    }

    Uri uri = Uri.parse(url);
    return uri;
  }

  Uri provideProceedWithPaymentsResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_PROCEED_WITH_PAYMENT_PATH,
    );
    return uri;
  }

  @override
  Uri provideMakePropertyFeaturedResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_MAKE_PROPERTY_FEATURED_PATH,
    );
    return uri;
  }

  @override
  Uri provideRemoveFromFeaturedResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_REMOVE_FROM_FEATURED_PATH,
    );
    return uri;
  }

  @override
  Uri provideUserMembershipPackageResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_USER_MEMBERSHIP_CURRENT_PACKAGE_PATH,
    );
    return uri;
  }

  @override
  Uri provideApproveDisapproveResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_APPROVE_DISAPPROVE_PATH,
    );
    return uri;
  }

  @override
  Uri provideToggleFeaturedResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_TOGGLE_FEATURED_PATH,
    );
    return uri;
  }

  @override
  Uri provideSetSoldStatusResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_SOLD_LISTING_PATH,
    );
    return uri;
  }

  @override
  Uri provideSetExpiredStatusResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_EXPIRE_LISTING_PATH,
    );
    return uri;
  }

  @override
  Uri provideSetPendingStatusResponseApi() {
    var uri = getUri(
      unEncodedPath: HOUZEZ_PENDING_LISTING_PATH,
    );
    return uri;
  }
}