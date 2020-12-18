import 'package:darmon/common/resources.dart';
import 'package:darmon/ui/main/main_viewmodel.dart';
import 'package:darmon/ui/main/search_index/search_index_fragment.dart';
import 'package:darmon/ui/main/setting_index/setting_index_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class MainFragment extends ViewModelFragment<MainViewModel> {
  static final String ROUTE_NAME = "/main";

  static void replace(BuildContext context) {
    Mold.replaceContent(context, ROUTE_NAME);
  }

  @override
  MainViewModel onCreateViewModel(BuildContext buildContext) => MainViewModel();

  @override
  Widget onCreateWidget(BuildContext context) {
    return StreamBuilder<int>(
        stream: viewmodel.currentItemIndex,
        builder: (_, snapshot) {
          if (snapshot?.data != null) {
            return Scaffold(
              backgroundColor: R.colors.background,
              body: getIndexFragment(snapshot.data),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: R.colors.background,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.format_list_bulleted_rounded),
                    label: R.strings.main.medicine.translate(),
                  ),
                  /*    BottomNavigationBarItem(
                    icon: Icon(Icons.comment),
                    label: 'Жалоба',
                  ),*/
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: R.strings.main.setting.translate(),
                  ),
                ],
                currentIndex: snapshot.data,
                selectedItemColor: R.colors.app_color,
                unselectedItemColor: R.colors.unselectedItemColor,
                onTap: _onItemTapped,
              ),
            );
          } else {
            return Container(child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  void _onItemTapped(int index) {
    viewmodel.setBottomNavigationBarItemIndex(index);
  }

  Widget getIndexFragment(int index) {
    switch (index) {
      case 0:
        return SearchIndexFragment().toFragment();
      case 1:
        return SettingIndexFragment().toFragment();
    }
    return Container(child: Center(child: CircularProgressIndicator()));
  }
}
