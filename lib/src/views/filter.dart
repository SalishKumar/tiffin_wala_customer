import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/models/item.dart';
import 'package:tiffin_wala_customer/src/view_model/filter_view_model.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

class Filter extends StatefulWidget {
  static const routeName = '/filter';
  List<Item1>? cusines;
  Filter({Key? key, this.cusines}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool? cusines = false, nearby = false;
  

  @override
  void initState() {
    data.filterApplied = false;
    if(data.subs){
      cusines = data.cusineSelected2;
    }else{
      cusines = data.cusineSelected1;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: cusines,
                      onChanged: (v) {
                        cusines = v;
                        setState(() {});
                      },
                      activeColor: color.purple,
                      title: Text(
                        "Cusines",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    cusines!
                        ? Container(
                            margin: EdgeInsets.only(left: 15),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.cusines!.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    value: widget.cusines![index].value,
                                    onChanged: (val) {
                                      widget.cusines![index].value =
                                          !widget.cusines![index].value;
                                      setState(() {});
                                    },
                                    title: Text(
                                      widget.cusines![index].name,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    activeColor: color.purple,
                                  );
                                }),
                          )
                        : Container(),
                    CheckboxListTile(
                      value: nearby,
                      onChanged: (val) {
                        nearby = val;
                        setState(() {});
                      },
                      title: Text(
                        "Near By",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      activeColor: color.purple,
                    )
                  ],
                ),
              )),
        ),
        bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: InkWell(
            onTap: () {
              data.filterApplied = true;
              if(data.subs){
                data.cusineSelected2 = cusines!;
              }else{
                data.cusineSelected1 = cusines!;
              }
              data.filteredList = [];
              if(cusines!){
                for(var item in widget.cusines!){
                  if(item.value){
                    data.filteredList.add(item);
                  }
                }
              }
              data.filteredList = data.filteredList.toSet().toList();
              Navigator.pop(context);
            },
            child: CustomButton(
              width: width,
              title: "Apply Filter",
            )),
      ),);
  }
}
