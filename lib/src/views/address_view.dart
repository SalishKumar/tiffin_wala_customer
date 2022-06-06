import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/view_model/address_view_model.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';

class AddressView extends StatelessWidget {
  static const routeName = '/addressView';

  const AddressView({Key? key}) : super(key: key);
  
  @override
  void initState() {
    
    
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: color.purple,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: color.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
            child: Consumer<AddressViewModel>(
                builder: (context, addressViewModel, child) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    DropdownButton<String>(
                      isExpanded: true,
      value: addressViewModel.dropdown,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: 16),
      underline: Container(
        height: 2,
        color: color.purple,
      ),
      onChanged: (String? newValue) {
        addressViewModel.dropdownFunction(newValue);
      },
      items: <String>['Home', 'Work']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
                    SizedBox(height: 20,),
                    MyCustomTextfield(
                      size: 500,
                      suffix: Icons.map,
                      onPressed: (){
                        Navigator.pushNamed(context, Maps.routeName);
                      },
                        textInputType: TextInputType.text,
                        hintText: 'Address',
                        label: 'Address',
                        prefix: Icons.location_pin,
                        error: addressViewModel.addressError,
                        controller: addressViewModel.addressCon,
                        onValidation: (){
                          addressViewModel.inputAddress();
                        }),
                        SizedBox(height: 20,),
                        MyCustomTextfieldWithoutSuffix(
                          size: 500,
                          width: width*0.9,
                          lines: 1,
                        textInputType: TextInputType.text,
                        hintText: 'Unit/Floor',
                        prefix: Icons.location_city,
                        error: addressViewModel.floorUnitError,
                        controller: addressViewModel.floorUnitCon,
                        onValidation: (){
                          addressViewModel.inputFloorUnit();
                        }),
                        SizedBox(height: 20,),
                        MyCustomTextfieldWithoutSuffix(
                          size: 500,
                          width: width*0.9,
                          lines: 3,
                        textInputType: TextInputType.text,
                        hintText: 'Note to Rider (optional)',
                        prefix: Icons.note,
                        error: addressViewModel.notesError,
                        controller: addressViewModel.notesCon,
                        onValidation: (){
                          
                        }),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05),
        child: InkWell(onTap: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, child: CustomButton(width: width, title: "Save",)),
      ),
    );
  }
}
