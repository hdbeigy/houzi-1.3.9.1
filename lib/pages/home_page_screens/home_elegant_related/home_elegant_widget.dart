import 'package:flutter/material.dart';
import 'package:jakojast/pages/home_page_screens/parent_home_related/parent_sliver_home.dart';

import 'package:jakojast/pages/home_page_screens/home_elegant_related/related_widgets/home_elegant_sliver_app_bar.dart';
import 'package:jakojast/pages/home_page_screens/home_elegant_related/related_widgets/home_elegant_widgets_listings.dart';

class HomeElegant extends ParentSliverHome {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const HomeElegant({
    Key? key,
    this.scaffoldKey
  }) : super(key: key);

  @override
  _HomeElegantState createState() => _HomeElegantState();
}

class _HomeElegantState extends ParentSliverHomeState<HomeElegant> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget getSliverAppBarWidget(){
    return HomeElegantSliverAppBarWidget(
      onLeadingIconPressed: ()=> widget.scaffoldKey!.currentState!.openDrawer(),
      homeElegantSliverAppBarListener: ({filterDataMap}){
        if(filterDataMap != null && filterDataMap.isNotEmpty){
          super.updateData(filterDataMap);
        }
      },
    );
  }

  @override
  Widget getListingsWidget(dynamic item){
    return HomeElegantListingsWidget(
      homeScreenData: item,
      refresh: super.needToRefresh,
      homeScreen02ListingsWidgetListener: (bool errorOccur, bool dataRefresh){
        if(mounted){
          setState(() {
            super.errorWhileDataLoading = errorOccur;
            super.needToRefresh = dataRefresh;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.scaffoldKey != null) {
      super.scaffoldKey = widget.scaffoldKey!;
    }

    return super.build(context);
  }
}
