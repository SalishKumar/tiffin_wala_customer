import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/models/complain.dart';
import 'package:tiffin_wala_customer/src/service/database.dart';
import 'package:tiffin_wala_customer/src/view_model/address_view_model.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';

class ComplainView extends StatefulWidget {
  static const routeName = '/complaint';
  int? id;
  ComplainView({ Key? key, this.id}) : super(key: key);

  @override
  State<ComplainView> createState() => _ComplainViewState();
}

class _ComplainViewState extends State<ComplainView> {
  TextEditingController text = TextEditingController();
  // double rating = 0.0;
  List<File> images = [];
  List<XFile> images1 = [];
  Database db = Database();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complain",
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
                    SizedBox(
                      height: 50,
                    ),
                    MyCustomTextfieldWithoutSuffix(
                        size: 500,
                        width: width * 0.9,
                        lines: 5,
                        textInputType: TextInputType.text,
                        hintText: 'Describe Your Issue',
                        prefix: Icons.note,
                        error: '',
                        controller: text,
                        onValidation: () {}),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Container(
                //   width: width * 0.45,
                //   child: AutoSizeText(
                //     "Rate Your Experience",
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   width: double.infinity,
                //   child: RatingStars(
                //     value: rating,
                //     onValueChanged: (v) {
                //       rating = v;
                //       setState(() {});
                //     },
                //     starBuilder: (index, color) => Icon(
                //       Icons.star,
                //       color: color,
                //     ),
                //     starCount: 5,
                //     starSize: 30,
                //     valueLabelColor: const Color(0xff9b9b9b),
                //     valueLabelTextStyle: const TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.w400,
                //         fontStyle: FontStyle.normal,
                //         fontSize: 12.0),
                //     valueLabelRadius: 10,
                //     maxValue: 5,
                //     starSpacing: 2.5,
                //     maxValueVisibility: true,
                //     valueLabelVisibility: true,
                //     animationDuration: Duration(milliseconds: 1000),
                //     valueLabelPadding:
                //         const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                //     valueLabelMargin: const EdgeInsets.only(right: 8),
                //     starOffColor: const Color(0xffe7e8ea),
                //     starColor: Colors.yellow,
                //   ),
                // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Image.file(
                                      images[index],
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: IconButton(onPressed: () {
                                      images.removeAt(index);
                                      images1.removeAt(index);
                                      setState(() {
                                        
                                      });
                                    },
                                    icon: Icon(Icons.close,
                                    color: Colors.white,
                                    size: 15,),
                                    color: Colors.white,),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: 10,),
                    if(images.length <6)
                    InkWell(
                      onTap: () async{
                        if(images.length<6){
                          await dilogueBox();
                          
                        }
                      },
                      child: CustomButton(
                        width: width*0.6,
                        title: "Add picture ${images.length}/6",
                      ),
                    )],
                ),
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: InkWell(
            onTap: () async{
              print("${images.isEmpty} ${text.text.isEmpty}");
              if(images.isNotEmpty || text.text.isNotEmpty){
                showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: color.purple,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Loading"),
                    ],
                  ),
                ),
              );
            },
          );
          Map<String, dynamic> map = {};
          map = {
            "order_id": widget.id!,
            "description": text.text.trim(),
          };
          FormData formData = FormData.fromMap(map);
          for(var image in images){
            var path = image.path;
           formData.files.add(MapEntry("images", await MultipartFile.fromFile(path, filename: path))); 
          }
          print(formData.files);
          dynamic result = await db.complainOrder(formData);
          Navigator.pop(context);
          if (result != null) {
            if (result['Timeout'] == 'true') {
              Fluttertoast.showToast(
                  msg: 'Your request has been timmed-out. Try again.',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (result["status"]) {
              data.complain = Complain.fromJson(result["complain"]);
              
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: result["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              
              
            } else if (result["status"] == false) {
              Fluttertoast.showToast(
                  msg: result["message"],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
              }else if (text.text.isEmpty){
                Fluttertoast.showToast(
                  msg: "Describe your Issue",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              }else if (images.isEmpty){
                Fluttertoast.showToast(
                  msg: "One Image is mandatory",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              }
              // Navigator.pop(context);
              // Navigator.pop(context);
            },
            child: CustomButton(
              width: width,
              title: "Submit",
            )),
      ),
    );
  }

  Future dilogueBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AlertDialog(
            elevation: 0,
            title: Text(
              "Pick Image",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Container(
              // width: MediaQuery.of(context).size.width * 0.6,
              // height: MediaQuery.of(context).size.height * 0.15,
              child: Text(
                "Pick Image from Files/Gallery or Capture it from Camera",
                style: TextStyle(fontSize: 16),
              ),),
            actions: [
              TextButton(
                child: Text(
                  "Gallery",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                
                dynamic image = await pickImageFromGallery();
                var path = image.path;
                          print(path);
                          images.add(File(path));
                          images1.add(image);
                          setState(() {
                            
                          });
                          Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "Camera",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  // Navigator.pop(context);
                dynamic image = await pickImageFromCamera();
                var path = image.path;
                          print(path);
                          images.add(File(path));
                          images1.add(image);
                          setState(() {
                            
                          });
                          Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future pickImageFromGallery() async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future pickImageFromCamera() async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }
}
