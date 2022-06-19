import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/constants/t_field.dart';
import 'package:tiffin_wala_customer/src/constants/textfield.dart';
import 'package:tiffin_wala_customer/src/view_model/address_view_model.dart';
import 'package:tiffin_wala_customer/src/views/addresses.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';

class AddressView extends StatefulWidget {
  static const routeName = '/addressView';

  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  AddressViewModel addressViewModel = AddressViewModel();
  @override
  void initState() {
    addressViewModel.initialize();
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
            child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
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
                        setState(() {
                          
                        });
                      },
                      items: <String>['Home', 'Work']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    tfield(
                      value: addressViewModel.address,
                        size: 500,
                        suffix: Icons.map,
                        onPressed: () {
                          Navigator.pushNamed(context, Maps.routeName);
                        },
                        textInputType: TextInputType.text,
                        hintText: 'Address',
                        label: 'Address',
                        disable: true,
                        prefix: Icons.location_pin,
                        error: addressViewModel.addressError,
                        onValidation: (v) {
                          addressViewModel.inputAddress(v);
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextfieldWithoutSuffix(
                      value: addressViewModel.note,
                        size: 500,
                        width: width * 0.9,
                        lines: 3,
                        textInputType: TextInputType.text,
                        hintText: 'Note to Rider (optional)',
                        prefix: Icons.note,
                        error: addressViewModel.notesError,
                        onValidation: (v) {
                          addressViewModel.inputNotes(v);
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: InkWell(
                          onTap: () async {
                            if(data.addressEdit){
                              await addressViewModel.editAddress(context);
                            }else{
                              await addressViewModel.newAddress(context);
                            }
                            //print("here");
                            data.address='';
                            data.lat=0.0;
                            data.long=0.0;
                            if(data.addressEdit){
                              data.addressEdit=false;
                            }
                            if (data.addressDirect) {
                              //print("here");
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Addresses()));
                            } else {
                              data.chosenAddress = data.user.address.length-1;
      Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          child: CustomButton(
                            width: width,
                            title: "Save",
                          )),
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}

