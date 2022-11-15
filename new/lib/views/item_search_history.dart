import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uzphariminfo/model/history_model.dart';
import 'package:uzphariminfo/utils/colors.dart';
import 'package:uzphariminfo/viewmodel/search_view_model.dart';
import '../pages/detail_page.dart';
import '../utils/prefs.dart';

Widget itemSearchHistory(
    SearchHistory item, BuildContext context, SearchViewModel viewModel) {
  String name = "";
  if (context.locale == Locale('uz', 'UZ')) {
    name = item.nameUz!;
  } else {
    name = item.nameRu!;
  }

  return Slidable(
      key: ValueKey(0),
      startActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              viewModel.removeFromSearchHistory(item);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 0.1,
                    color: Colors.black
                )
            )
        ),
        child: TextButton(
          onPressed: (){

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPage(query: item.query, type: item.type, name: name),
                )
            );
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.history,
                              color: BColors.historyIconColor,
                              size: 24,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                name,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: BColors.about_TextColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(width: 10,),
                  Container(
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: BColors.historyIconColor,
                      size: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
  );
}
