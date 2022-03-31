import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/view_model/address_view_model.dart';
import 'package:tiffin_wala_customer/src/views/maps.dart';

class Review extends StatelessWidget {
  static const routeName = '/review';

  const Review({Key? key}) : super(key: key);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review",
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
                        hintText: 'Describe Your Experience (optional)',
                        prefix: Icons.note,
                        error: '',
                        controller: TextEditingController(),
                        onValidation: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width * 0.45,
                      child: AutoSizeText(
                        "Rate Your Experience",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: width * 0.4,
                      child: RatingStars(
                        value: 3.5,
                        onValueChanged: (v) {},
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        starCount: 5,
                        starSize: 20,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        valueLabelRadius: 10,
                        maxValue: 5,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: true,
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 150,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images.jpg",
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
                    CustomButton(
                      width: width*0.6,
                      title: "Add picture 5/6",
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
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: CustomButton(
              width: width,
              title: "Submit",
            )),
      ),
    );
  }
}
