import 'package:flutter/cupertino.dart';
import 'package:jakojast/common/constants.dart';
import 'package:jakojast/files/item_design_files/design_storage_manager.dart';

class ItemDesignNotifier with ChangeNotifier{

  String _homeScreenItemDesign = '';
  String _exploreByTypeItemDesign = '';

  String get homeScreenItemDesign => _homeScreenItemDesign;
  String get exploreByTypeItemDesign => _exploreByTypeItemDesign;

  ItemDesignNotifier(){

    _homeScreenItemDesign = ItemDesignStorageManager.readItemDesignData(HOME_SCREEN_ITEM_DESIGN) ?? DESIGN_01;
    _exploreByTypeItemDesign = ItemDesignStorageManager.readItemDesignData(EXPLORE_BY_TYPE_ITEM_DESIGN) ?? DESIGN_01;
    notifyListeners();
  }

  void setHomeScreenItemDesign(String itemDesign){
    _homeScreenItemDesign = itemDesign;
    ItemDesignStorageManager.saveItemDesignData(HOME_SCREEN_ITEM_DESIGN, itemDesign);
    notifyListeners();
  }

  void setExploreByTypeItemDesign(String itemDesign){
    _exploreByTypeItemDesign = itemDesign;
    ItemDesignStorageManager.saveItemDesignData(EXPLORE_BY_TYPE_ITEM_DESIGN, itemDesign);
    notifyListeners();
  }
}