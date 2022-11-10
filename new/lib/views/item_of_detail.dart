import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uzphariminfo/pages/preparation_page.dart';
import 'package:uzphariminfo/utils/colors.dart';
import 'package:uzphariminfo/utils/ext_functions.dart';
import '../model/detail_model.dart';

Widget itemOfDetail(Data data, BuildContext context) {
  String price = 'item_price_null'.tr();
  String item_price = 'item_price'.tr();
  String item_som = 'item_som'.tr();
  return Container(
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
              builder: (context) => PreparationPage(
                box_group_id: data.boxGroupId,
              ),
            )
        );
      },
      child: Center(
        child:  Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.boxGenName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$item_price: ${data.retailPriceBase.isNotEmpty ? data.retailPriceBase.toMoneyFormat() + item_som : price}',
                          style: TextStyle(
                              color: BColors.backgroundColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ).tr()
                      ],
                    )
                ),
                SizedBox(
                  width: 10,
                ),
                Stack(
                  children: [
                    data.spreadKind == "O"
                        ? Text(
                      "item_spreadKind_o",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16),
                    ).tr()
                        : Text("item_spreadKind_w",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.red))
                        .tr()
                  ],
                )
              ],
            )),
      ),
    ),
  );
}
