import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uzphariminfo/model/preparation_model.dart';
import '../utils/colors.dart';

Widget veiwOfPreparation(Preparation preparation) {
  String price = 'item_price_null'.tr();
  String item_price = 'item_price'.tr();
  String item_som = 'item_som'.tr();
  bool isVisible = false;
  if (preparation.retailPriceBase.toString().isNotEmpty) {
    isVisible = true;
  }

  return Container(
    color: BColors.backgroundColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'manufacturer',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ).tr(),
                  Stack(
                    children: [
                      preparation.spreadKind == "W" ? Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "item_spreadKind_w",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ).tr(),
                      )
                          : Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "item_spreadKind_o",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ).tr(),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                preparation.producerGenName.toString(),
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                preparation.boxGenName.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          preparation.retailPriceBase.toString().isNotEmpty
                              ? preparation.retailPriceBase
                                  .toString()
                              : price,
                          style: TextStyle(
                            fontSize: 29,
                            color: Colors.white,
                          ),
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Text(
                            item_som,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      item_price,
                      style: TextStyle(color: Colors.white54),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
