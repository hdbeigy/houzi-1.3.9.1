import 'package:jakojast/common/constants.dart';
import 'package:jakojast/files/hive_storage_files/hive_storage_manager.dart';

class FilterPageFunctions {

  static List<dynamic> getTermDataFromStorage (String key) {
    switch (key) {
      case propertyTypeDataType: {
        return HiveStorageManager.readPropertyTypesMetaData() ?? [];
      }

      case propertyStatusDataType: {
        return HiveStorageManager.readPropertyStatusMetaData() ?? [];
      }

      case propertyLabelDataType: {
        return HiveStorageManager.readPropertyLabelsMetaData() ?? [];
      }

      case propertyAreaDataType: {
        return HiveStorageManager.readPropertyAreaMetaData() ?? [];
      }

      case propertyCityDataType: {
        return HiveStorageManager.readCitiesMetaData() ?? [];
      }

      case propertyStateDataType: {
        return HiveStorageManager.readPropertyStatesMetaData() ?? [];
      }

      case propertyCountryDataType: {
        return HiveStorageManager.readPropertyCountriesMetaData() ?? [];
      }

      case propertyFeatureDataType: {
        return HiveStorageManager.readPropertyFeaturesMetaData() ?? [];
      }

      default: {
        return [];
      }
    }
  }
}