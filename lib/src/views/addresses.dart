import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/models/address.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/views/address_view.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;

class Addresses extends StatefulWidget {
  static const routeName = '/addresses';
  int? chosenAddress;

  Addresses({Key? key, this.chosenAddress}) : super(key: key);
  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  late User1 user;
  bool isData = true;

  @override
  void initState() {
    if(data.user.address.isEmpty){
      isData = false;
    }else{
      isData=true;
      user = data.user;
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Addresses",
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
            child: isData ? Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user.address.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          data.chosenAddress = index;
                          print("${data.chosenAddress} $index");
                          Navigator.pop(context);
                        },
                        child: addressBox(
                          user.address[index],
                          width,
                          context,
                        ));
                  }),
            ):Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text("No Addresses Available",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),)
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: InkWell(
            onTap: () {
              data.lat = 24.860966;
              data.long = 66.990501;
              data.label = '';
              data.address = '';
              data.notes = '';
              Navigator.push(context, MaterialPageRoute(builder: (context) => Maps())).then((value) {
                if(data.user.address.isNotEmpty){
                  isData = true;
                }else{
                  isData=false;
                }
                //data.chosenAddress = user.address.length-1;
                if (data.addressDirect == false){
      
    }
                user.address = data.user.address;
                setState(() {});
              });
            },
            child: CustomButton(
              width: width,
              title: "New Address",
            )),
      ),
    );
  }

  Widget addressBox(Address address, double width, BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: color.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        address.label!,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: color.purple,
                  ),
                  onPressed: () {
                    data.address = address.address!;
                    data.notes = address.notes!;
                    data.lat = address.lat;
                    data.long = address.long;
                    data.label = address.label!;
                    data.adressID = address.id;
                    data.addressEdit = true;
                    Navigator.pushNamed(context, AddressView.routeName)
                        .then((value) {
                      if(data.user.address.isNotEmpty){
                  isData = true;
                }else{
                  isData=false;
                }
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                address.address!,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              child: AutoSizeText(
                "Karachi",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
