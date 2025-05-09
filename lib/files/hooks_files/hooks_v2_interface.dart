import 'package:jakojast/files/hooks_files/hooks_configurations.dart';
import 'package:jakojast/providers/state_providers/locale_provider.dart';
import 'package:jakojast/files/configurations/app_configurations.dart';
import 'package:jakojast/files/generic_methods/utility_methods.dart';
import 'package:jakojast/main.dart';
import 'package:jakojast/l10n/l10n.dart';
import 'package:jakojast/pages/home_page_screens/home_elegant_related/related_widgets/home_elegant_sliver_app_bar.dart';
import 'package:jakojast/pages/home_page_screens/parent_home_related/home_screen_widgets/home_screen_drawer_widgets/home_screen_drawer_widget.dart';
import 'package:jakojast/pages/home_page_screens/parent_home_related/home_screen_widgets/home_screen_realtors_related_widgets/home_screen_realtors_list_widget.dart';
import 'package:jakojast/pages/home_screen_drawer_menu_pages/settings_page.dart';
import 'package:jakojast/pages/home_screen_drawer_menu_pages/user_related/phone_sign_in_widgets/user_get_phone_number.dart';
import 'package:jakojast/pages/home_screen_drawer_menu_pages/user_related/user_profile.dart';
import 'package:jakojast/pages/map_view.dart';
import 'package:jakojast/pages/property_details_related_pages/pd_widgets_listing.dart';
import 'package:jakojast/widgets/article_box_widgets/article_box_design.dart';
import 'package:jakojast/widgets/custom_segment_widget.dart';
import 'package:jakojast/widgets/explore_by_type_design_widgets/explore_by_type_design.dart';
import 'package:jakojast/widgets/filter_page_widgets/term_picker_related/term_picker.dart';
import 'package:jakojast/widgets/generic_text_field_widgets/text_field_widget.dart';

abstract class HooksV2Interface{
  Map<String, dynamic> getHeaderMap();
  Map<String, dynamic> getPropertyDetailPageIconsMap();
  Map<String, dynamic> getElegantHomeTermsIconMap();
  DrawerHook getDrawerItems();
  FontsHook getFontHook();
  PropertyItemHook getPropertyItemHook();
  PropertyItemHookV2 getPropertyItemHookV2();
  PropertyItemHeightHook getPropertyItemHeightHook();
  TermItemHook getTermItemHook();
  AgentItemHook getAgentItemHook();
  AgencyItemHook getAgencyItemHook();
  PropertyPageWidgetsHook getWidgetHook();
  LanguageHook getLanguageCodeAndName();
  DefaultLanguageCodeHook getDefaultLanguageHook();
  DefaultHomePageHook getDefaultHomePageHook();
  DefaultCountryCodeHook getDefaultCountryCodeHook();
  SettingsHook getSettingsItemHook();
  ProfileHook getProfileItemHook();
  HomeRightBarButtonWidgetHook getHomeRightBarButtonWidgetHook();
  MarkerTitleHook getMarkerTitleHook();
  MarkerIconHook getMarkerIconHook();
  CustomMarkerHook getCustomMarkerHook();
  PriceFormatterHook getPriceFormatterHook();
  CompactPriceFormatterHook getCompactPriceFormatterHook();
  TextFormFieldCustomizationHook getTextFormFieldCustomizationHook();
  TextFormFieldWidgetHook getTextFormFieldWidgetHook();
  CustomSegmentedControlHook getCustomSegmentedControlHook();
  DrawerHeaderHook getDrawerHeaderHook();
  HidePriceHook getHidePriceHook();
  HideEmptyTerm hideEmptyTerm();
  HomeSliverAppBarBodyHook getHomeSliverAppBarBodyHook();
  HomeWidgetsHook getHomeWidgetsHook();
  DrawerWidgetsHook getDrawerWidgetsHook();
  MembershipPlanHook getMembershipPlanHook();
  PaymentHook getPaymentHook();
  PaymentSuccessfulHook getPaymentSuccessfulHook();
  MembershipPackageUpdatedHook getMembershipPackageUpdatedHook();
  AddPlusButtonInBottomBarHook getAddPlusButtonInBottomBarHook();
  NavbarWidgetsHook getNavbarWidgetsHook();
  ClusterMarkerIconHook getCustomizeClusterMarkerIconHook();
  CustomClusterMarkerIconHook getCustomClusterMarkerIconHook();
  MembershipPayWallDesignHook getMembershipPayWallDesignHook();
  MinimumPasswordLengthHook getMinimumPasswordLengthHook();
  AgentProfileConfigurationsHook getAgentProfileConfigurationsHook();
}