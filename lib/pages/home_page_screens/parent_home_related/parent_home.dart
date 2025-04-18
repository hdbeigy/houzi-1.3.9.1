import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jakojast/blocs/property_bloc.dart';
import 'package:jakojast/common/constants.dart';
import 'package:jakojast/files/app_preferences/app_preferences.dart';
import 'package:jakojast/files/generic_methods/general_notifier.dart';
import 'package:jakojast/files/generic_methods/utility_methods.dart';
import 'package:jakojast/files/hive_storage_files/hive_storage_manager.dart';
import 'package:jakojast/files/property_manager_files/property_manager.dart';
import 'package:jakojast/pages/home_page_screens/parent_home_related/home_screen_utilities.dart';
import 'package:jakojast/pages/home_page_screens/parent_home_related/home_screen_widgets/home_screen_drawer_widgets/home_screen_drawer_widget.dart';
import 'package:jakojast/pages/home_page_screens/parent_home_related/home_screen_widgets/home_screen_listing_widgets/generic_home_screen_listings.dart';
import 'package:jakojast/providers/state_providers/user_log_provider.dart';
import 'package:jakojast/widgets/custom_widgets/refresh_indicator_widget.dart';
import 'package:jakojast/widgets/no_internet_botton_widget.dart';
import 'package:jakojast/widgets/toast_widget.dart';
import 'package:provider/provider.dart';

class ParentHome extends StatefulWidget {
  const ParentHome({super.key});

  @override
  State<ParentHome> createState() => ParentHomeState();
}

class ParentHomeState<T extends ParentHome> extends State<T> {
  bool _isFree = false;
  bool _isLoggedIn = false;
  bool errorWhileDataLoading = false;
  bool needToRefresh = false;

  int? _selectedCityId;
  int? uploadedPropertyId;

  String _selectedCity = "";
  String _userImage = "";
  String _userName = "";
  String? _userRole;

  List<dynamic> homeConfigList = [];
  List<dynamic> drawerConfigList = [];
  List<dynamic> propertyStatusListWithData = [];

  Map<String, dynamic> filterDataMap = {};

  VoidCallback? propertyUploadListener;
  VoidCallback? generalNotifierListener;

  final PropertyBloc _propertyBloc = PropertyBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  set scaffoldKey(GlobalKey<ScaffoldState> value) {
    _scaffoldKey = value;
  }

  GlobalKey<ScaffoldState> get parentHomeScaffoldKey => _scaffoldKey;

  String get userName => _userName;

  @override
  void initState() {
    clearMetaData();
    loadData();
    getHomeConfigFile();
    getDrawerConfigFile();
    super.initState();
  }

  @override
  void dispose() {
    _selectedCity = "";
    _userImage = "";
    _userName = "";
    _userRole = null;
    _selectedCityId = null;
    uploadedPropertyId = null;
    homeConfigList = [];
    drawerConfigList = [];
    propertyStatusListWithData = [];
    filterDataMap = {};

    if (propertyUploadListener != null) {
      PropertyManager().removeListener(propertyUploadListener!);
    }
    if (generalNotifierListener != null) {
      GeneralNotifier().removeListener(generalNotifierListener!);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: HomeScreenUtilities().getSystemUiOverlayStyle(design: HOME_SCREEN_DESIGN),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          key: _scaffoldKey,
          drawer: HomeScreenDrawerWidget(
            drawerConfigDataList: drawerConfigList,
            userInfoData: {
              USER_PROFILE_NAME : _userName,
              USER_PROFILE_IMAGE : _userImage,
              USER_ROLE : _userRole,
              USER_LOGGED_IN : _isLoggedIn,
            },
            homeScreenDrawerWidgetListener: (bool loginInfo){
              if(mounted){
                setState(() {
                  _isLoggedIn = loginInfo;
                });
              }
            },
          ),
          body: getBodyWidget(),

        ),
      ),
    );
  }

  Widget getBodyWidget() {
    return RefreshIndicatorWidget(
      color: AppThemePreferences.appPrimaryColor,
      edgeOffset: 200.0,
      onRefresh: () async => onRefresh(),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: homeConfigList.map((item) {
                        return getListingsWidget(item);
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
          if (errorWhileDataLoading) getInternetConnectionErrorWidget(),
        ],
      ),
    );
  }

  Widget getInternetConnectionErrorWidget(){
    return InternetConnectionErrorWidget(
      onPressed: ()=> checkInternetAndLoadData(),
    );
  }

  Widget getListingsWidget(dynamic item) {
    return HomeScreenListingsWidget(
      homeScreenData: item,
      refresh: needToRefresh,
      homeScreenListingsWidgetListener: (bool errorOccur, bool dataRefresh) {
        if (mounted) {
          setState(() {
            errorWhileDataLoading = errorOccur;
            needToRefresh = dataRefresh;
          });
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchPropertyMetaData() async {
    Map<String, dynamic> _metaDataMap = {};
    _metaDataMap = await _propertyBloc.fetchPropertyMetaData();
    return _metaDataMap;
  }

  void onRefresh() {
    setState(() {
      clearMetaData();
      needToRefresh = true;
    });
    loadData();
  }

  void checkInternetAndLoadData() {
    needToRefresh = true;
    errorWhileDataLoading = false;
    loadData();
    if (mounted) {
      setState(() {});
    }
  }

  void loadData() {
    /// Load Data From Storage
    filterDataMap = HiveStorageManager.readFilterDataInfo() ?? {};
    _userRole = HiveStorageManager.getUserRole() ?? "";
    _userName = HiveStorageManager.getUserName() ?? "";
    _userImage = HiveStorageManager.getUserAvatar() ?? "";

    /// General Notifier Listener
    generalNotifierListener = () {
      if (GeneralNotifier().change == GeneralNotifier.USER_PROFILE_UPDATE) {
        if (mounted) {
          setState(() {
            _userName = HiveStorageManager.getUserName() ?? "";
            _userImage = HiveStorageManager.getUserAvatar() ?? "";
          });
        }
      }

      if (GeneralNotifier().change ==
          GeneralNotifier.APP_CONFIGURATIONS_UPDATED) {
        if (mounted) {
          setState(() {
            getHomeConfigFile();
            getDrawerConfigFile();
          });
        }
      }
    };

    /// Property Upload Listener
    propertyUploadListener = () {
      if (mounted) {
        setState(() {
          _isFree = PropertyManager().isPropertyUploaderFree;
          uploadedPropertyId = PropertyManager().uploadedPropertyId;
        });
      }

      if (uploadedPropertyId != null) {
        int propertyId = uploadedPropertyId!;
        ShowToastWidget(
            buildContext: context,
            showButton: true,
            buttonText: UtilityMethods.getLocalizedString("view"),
            text: UtilityMethods.getLocalizedString("property_uploaded"),
            toastDuration: 4,
            onButtonPressed: () {
              UtilityMethods.navigateToPropertyDetailPage(
                context: context,
                propertyID: propertyId,
                heroId: '$propertyId$SINGLE',
              );
            });
        PropertyManager().uploadedPropertyId = null;
      }
    };
    PropertyManager().addListener(propertyUploadListener!);

    GeneralNotifier().addListener(generalNotifierListener!);

    if (Provider.of<UserLoggedProvider>(context, listen: false).isLoggedIn ??
        false) {
      PropertyManager().uploadProperty();
      if (mounted) {
        setState(() {
          _isLoggedIn = true;
        });
      }
    }

    /// Fetch the last selected City Data form Filter Data
    if (filterDataMap.isNotEmpty) {
      if (mounted) {
        setState(() {
          if (filterDataMap.containsKey(CITY) && filterDataMap[CITY] != null) {
            if (filterDataMap[CITY] is List && filterDataMap[CITY].isNotEmpty) {
              _selectedCity = filterDataMap[CITY][0];
            } else if (filterDataMap[CITY] is String) {
              _selectedCity = filterDataMap[CITY];
            }
          }

          if (filterDataMap.containsKey(CITY_ID) &&
              filterDataMap[CITY_ID] != null) {
            if (filterDataMap[CITY_ID] is List &&
                filterDataMap[CITY_ID].isNotEmpty &&
                filterDataMap[CITY_ID][0] is int) {
              _selectedCityId = filterDataMap[CITY_ID][0];
            } else if (filterDataMap[CITY_ID] is int) {
              _selectedCityId = filterDataMap[CITY_ID];
            }
          }
        });
      }
    }

    loadRemainingData();
  }

  void loadRemainingData() {
    fetchPropertyMetaData().then((value) {
      if (value['response'].runtimeType == Response) {
        errorWhileDataLoading = true;
      } else if (value.isNotEmpty) {
        UtilityMethods.updateTouchBaseDataAndConfigurations(value);
      }

      if (needToRefresh) {
        GeneralNotifier().publishChange(GeneralNotifier.TOUCH_BASE_DATA_LOADED);
      }

      // needToRefresh = false;
      if (mounted) {
        setState(() {});
      }
      return null;
    });
  }

  void clearMetaData() {
    HiveStorageManager.clearData();
  }

  String getSelectedCity() {
    if (filterDataMap.isNotEmpty &&
        filterDataMap[CITY] != null &&
        filterDataMap[CITY].isNotEmpty) {
      if (filterDataMap[CITY] is List) {
        return filterDataMap[CITY][0];
      } else if (filterDataMap[CITY] is String) {
        return filterDataMap[CITY];
      }
    } else if (_selectedCity.isNotEmpty) {
      return _selectedCity;
    }

    return "please_select";
    // return UtilityMethods.getLocalizedString("please_select");
  }

  int getSelectedStatusIndex() {
    if (filterDataMap.isNotEmpty &&
        filterDataMap.containsKey(PROPERTY_STATUS_SLUG) &&
        filterDataMap[PROPERTY_STATUS_SLUG] != null &&
        filterDataMap[PROPERTY_STATUS_SLUG].isNotEmpty) {
      int index = propertyStatusListWithData.indexWhere(
          (element) => element.slug == filterDataMap[PROPERTY_STATUS_SLUG]);
      if (index != -1) {
        return index;
      }
    }

    return 0;
  }

  void updateData(Map<String, dynamic> map) {
    if (mounted) {
      setState(() {
        filterDataMap = map;

        if (filterDataMap[CITY] is List) {
          // _selectedCity = filterDataMap[CITY][0] ?? UtilityMethods.getLocalizedString("please_select");
          _selectedCity = filterDataMap[CITY][0] ?? "please_select";
        } else if (filterDataMap[CITY] is String) {
          // _selectedCity = filterDataMap[CITY] ?? UtilityMethods.getLocalizedString("please_select");
          _selectedCity = filterDataMap[CITY] ?? "please_select";
        }
        _selectedCityId = filterDataMap[CITY_ID] is List
            ? filterDataMap[CITY_ID][0]
            : filterDataMap[CITY_ID];

        Map cityData = HiveStorageManager.readSelectedCityInfo();
        if (cityData.isNotEmpty) {
          var oldSelectedCityId = cityData[CITY_ID];

          if (oldSelectedCityId != _selectedCityId) {
            if (filterDataMap[CITY] is List) {
              saveSelectedCityInfo(
                  _selectedCityId, _selectedCity, filterDataMap[CITY_SLUG][0]);
            } else if (filterDataMap[CITY] is String) {
              saveSelectedCityInfo(
                  _selectedCityId, _selectedCity, filterDataMap[CITY_SLUG]);
            }
          }
        } else {
          if (filterDataMap[CITY] is List) {
            saveSelectedCityInfo(
                _selectedCityId, _selectedCity, filterDataMap[CITY_SLUG][0]);
          } else if (filterDataMap[CITY] is String) {
            saveSelectedCityInfo(
                _selectedCityId, _selectedCity, filterDataMap[CITY_SLUG]);
          }
        }
        GeneralNotifier()
            .publishChange(GeneralNotifier.FILTER_DATA_LOADING_COMPLETE);
      });
    }
  }

  void saveSelectedCityInfo(int? cityId, String cityName, String citySlug) {
    HiveStorageManager.storeSelectedCityInfo(
      data: {
        CITY: cityName,
        CITY_ID: cityId,
        CITY_SLUG: citySlug,
      },
    );
    GeneralNotifier().publishChange(GeneralNotifier.CITY_DATA_UPDATE);
  }

  void getHomeConfigFile() {
    if (mounted) {
      setState(() {
        homeConfigList = UtilityMethods.readHomeConfigFile();
      });
    }
  }

  void getDrawerConfigFile() {
    if (mounted) {
      setState(() {
        drawerConfigList = UtilityMethods.readDrawerConfigFile();
      });
    }
  }
}

class InternetConnectionErrorWidget extends StatelessWidget {
  final Function()? onPressed;

  const InternetConnectionErrorWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SafeArea(
        top: false,
        child: NoInternetBottomActionBarWidget(
          onPressed: onPressed,
        ),
      ),
    );
  }
}

