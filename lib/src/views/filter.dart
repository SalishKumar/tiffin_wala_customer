import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/view_model/Filter_view_model.dart';

class Filter extends StatelessWidget {
  static const routeName = '/filter';

  const Filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    FilterViewModel filterViewModel =
        Provider.of<FilterViewModel>(context, listen: false);
    return Scaffold(
        backgroundColor: color.background,
        appBar: AppBar(
          title: Text(
            "Filters",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Consumer<FilterViewModel>(
                builder: (context, filterViewModel, child) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CheckboxListTile(value: filterViewModel.cusines, onChanged: (v){
                      filterViewModel.cusineSelection();
                    },
                    title: Text(
                      "Cusines",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),),
                    filterViewModel.cusines?Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          CheckboxListTile(value: filterViewModel.listOfCusines[0], onChanged: filterViewModel.cusineChanged(0),title: Text(
                      "Karhai",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),),
                    CheckboxListTile(value: filterViewModel.listOfCusines[0], onChanged: filterViewModel.cusineChanged(0),title: Text(
                      "Karhai",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),),
                    CheckboxListTile(value: filterViewModel.listOfCusines[0], onChanged: filterViewModel.cusineChanged(0),title: Text(
                      "Karhai",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),),
                        ],
                      ),
                    ):Container(),
                    CheckboxListTile(value: filterViewModel.nearby, onChanged: filterViewModel.nearbySelection(),title: Text(
                      "Near By",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),)
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
