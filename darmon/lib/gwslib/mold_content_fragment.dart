import 'package:darmon/common/resources.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

abstract class MoldContentFragment<VM extends ViewModel> extends ViewModelFragment<VM> {

  MyAppBar buildToolbar({dynamic leading, dynamic title, String subTitle, List<MenuItem> menus}) {
    Widget leadingWidget;
    if (leading is Widget) {
      leadingWidget = leading;
    } else if (leading is GlobalKey<ScaffoldState>) {
      GlobalKey<ScaffoldState> key = leading;
      leadingWidget = IconButton(
        icon: MyIcon.svg(R.asserts.drawer_menu),
        onPressed: () => key.currentState.openDrawer(),
      );
    } else if (Navigator.of(getContext()).canPop()) {
      leadingWidget = IconButton(
        icon: MyIcon.svg(R.asserts.leading_back),
        onPressed: () => Navigator.of(getContext()).pop(),
      );
    }

    Widget titleWidget;
    if (title is Widget) {
      titleWidget = title;
    } else if (title is String) {
      titleWidget = MyText(title);
    }

    List<Widget> toolbarActions = [];
    if (menus != null && menus.isNotEmpty) {
      // search action
      //

      // default icon action
      toolbarActions.addAll(menus.where((it) => it.isIcon()).map((it) => it.toWidget()));

      // submenu actions
      List<MenuItem> subMenus = menus.where((it) => it.isSub()).toList();
      if (subMenus.isNotEmpty) {
        toolbarActions.add(PopupMenuButton<int>(
          onSelected: (index) => subMenus[index].callback.call(),
          itemBuilder: (context) {
            List<PopupMenuItem<int>> popupList = [];
            for (int i = 0; i < subMenus.length; i++) {
              final subItem = subMenus[i];
              popupList.add(PopupMenuItem<int>(value: i, child: MyText(subItem.text)));
            }
            return popupList;
          },
        ));
      }
    }
    return new MyAppBar(leading: leadingWidget, title: titleWidget, actions: toolbarActions);
  }
}

class MenuItem {
  static final int ICON = 1;
  static final int SUB = 2;
  static final int SEARCH = 3;

  final int type;
  final Widget widget;
  final Widget icon;
  final String text;
  final String hintText;
  final VoidCallback callback;

  MenuItem({this.type, this.widget, this.icon, this.text, this.hintText, this.callback});

  factory MenuItem.icon({dynamic icon, String hintText, VoidCallback callback}) {
    Widget iconWidget = icon is IconData ? MyIcon.icon(icon) : MyIcon.svg(icon);
    return MenuItem(type: ICON, icon: iconWidget, hintText: hintText ?? "", callback: callback);
  }

  factory MenuItem.sub({String text, VoidCallback callback}) {
    return MenuItem(type: SUB, text: text, callback: callback);
  }

  bool isIcon() => type == ICON;

  bool isSub() => type == SUB;

  Widget toWidget() {
    return widget ?? IconButton(icon: icon, tooltip: text, onPressed: callback);
  }
}
