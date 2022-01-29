import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/view_model/filter_view_model.dart';

class Filter extends StatelessWidget {
  static const routeName = '/filter';

  const Filter({Key? key}) : super(key: key);

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
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
            },
            ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Consumer<FilterViewModel1>(
                builder: (context, filterViewModel, child) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CheckboxListTile(value: filterViewModel.cusines, onChanged: (v){
                      filterViewModel.cusineSelection();
                    },
                    activeColor: color.purple,
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
                          CheckboxListTile(value: filterViewModel.listOfCusines[0], onChanged: (val)=>filterViewModel.cusineChanged(0),title: Text(
                      "Biryani",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    activeColor: color.purple,),
                    CheckboxListTile(value: filterViewModel.listOfCusines[1], onChanged: (val)=>filterViewModel.cusineChanged(1),title: Text(
                      "Karhai",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    activeColor: color.purple,),
                    CheckboxListTile(value: filterViewModel.listOfCusines[2], onChanged:(val)=> filterViewModel.cusineChanged(2),title: Text(
                      "Daal",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    activeColor: color.purple,),
                        ],
                      ),
                    ):Container(),
                    CheckboxListTile(value: filterViewModel.nearby, onChanged: (val)=> filterViewModel.nearbySelection(),title: Text(
                      "Near By",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    activeColor: color.purple,)
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
