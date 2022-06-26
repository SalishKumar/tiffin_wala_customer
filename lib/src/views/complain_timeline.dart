import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/custom_button.dart';
import 'package:tiffin_wala_customer/src/models/complain.dart';

class ComplainTimeline extends StatefulWidget {
  Complain? complain;
  ComplainTimeline({ Key? key, this.complain }) : super(key: key);

  @override
  State<ComplainTimeline> createState() => _ComplainTimelineState();
}

class _ComplainTimelineState extends State<ComplainTimeline> {
  bool dicriptionLess = true;
  bool resolutionLess = true;
  String expandDiscription = 'See more';
  String expandResoutionl = 'See more';
  double rating = 0.0;
  List<NetworkImage> imgs = [];
  
  @override
  void initState() {
    if(widget.complain!.images!.isNotEmpty){
      for(var pics in widget.complain!.images!){
        imgs.add(NetworkImage(pics));
      }
    }
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          //height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              complainInfo(width * 0.9),
              SizedBox(height: 20,),
              const Text(
                  'Complain',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
              complainTileM(16.0),
              SizedBox(height: 20,),
              if(widget.complain!.isResoved!)
              const Text(
                  'Resolution',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                if(widget.complain!.isResoved!)
                SizedBox(height: 10,),
                if(widget.complain!.isResoved!)
              resolutionTileM(16.0),
              widget.complain!.isResoved! && widget.complain!.isCustomerRating! ?
              SizedBox(height: 20,):SizedBox(height: 20,),
              widget.complain!.isResoved! && widget.complain!.isCustomerRating! ?
              const Text(
                  'Rating',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ):GestureDetector(onTap: () async{
                  await rateAResolution();
                }, child: CustomButton(width: width, title: "Rate Resolution")),
                if(widget.complain!.isResoved! && widget.complain!.isCustomerRating!)
                SizedBox(height: 10,),
                if(widget.complain!.isResoved! && widget.complain!.isCustomerRating!)
              ratingTileM(16.0, 16.0),
                SizedBox(height: 10,),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget complainInfo(width) {
    return Container(
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Complain ID: ',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.complain!.id!.toString(),
                style: TextStyle(
                    color: color.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Name: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.complain!.customerName!,
                style: TextStyle(
                    color: color.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kitchen Name: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.complain!.kitchenName!,
                style: TextStyle(
                    color: color.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.complain!.status!,
                style: TextStyle(
                    color: color.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget complainTileM(fontsize) {
    print("no problem");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discription: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: fontsize,
                fontWeight: FontWeight.bold
              ),
            ),
          
        //SizedBox(height: 5,),
        dicriptionLess
            ? Expanded(
                child: Text(
                  widget.complain!.desc!,
                  style: TextStyle(
                    color: color.purple,
                    fontSize: fontsize,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              )
            : Expanded(
                child: Text(
                  widget.complain!.desc!,
                  style: TextStyle(
                    color: color.purple,
                    fontSize: fontsize,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              ],
        ),
        InkWell(
          onTap: () {
            if (dicriptionLess) {
              dicriptionLess = false;
              expandDiscription = 'See less';
            } else {
              dicriptionLess = true;
              expandDiscription = 'See more';
            }
            setState(() {});
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              expandDiscription,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: fontsize
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if(widget.complain!.images!.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photos: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: fontsize,
                    fontWeight: FontWeight.bold
              ),
            ),
          
        SizedBox(
            height: 199.0,
            width: 300.0,
            child: Carousel(
              images: imgs,
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.purple.withOpacity(0.5),
              borderRadius: true,
              moveIndicatorFromBottom: 180.0,
              noRadiusForIndicator: true,
            )),
        ],
        ),
      ],
    );
  }

  Widget resolutionTileM(fontsize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resolution: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: fontsize,
                fontWeight: FontWeight.bold
              ),
            ),
          
        resolutionLess
            ? Expanded(
                child: Text(
                  widget.complain!.resolution!,
                  style: TextStyle(
                    color: color.purple,
                    fontSize: fontsize,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              )
            : Expanded(
                child: Text(
                  widget.complain!.resolution!,
                  style: TextStyle(
                    color: color.purple,
                    fontSize: fontsize,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              ],
        ),
        InkWell(
          onTap: () {
            if (resolutionLess) {
              resolutionLess = false;
              expandResoutionl = 'See less';
            } else {
              resolutionLess = true;
              expandResoutionl = 'See more';
            }
            setState(() {});
          },
          child: Container(
            alignment: Alignment.topRight,
            child: Text(
              expandResoutionl,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: fontsize
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        if(widget.complain!.voucherIssued!)
        Center(
          child: Text(
                  'Issued Voucher',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
          ),
        ),
        if(widget.complain!.voucherIssued!)
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Voucher Code: ',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.complain!.voucher!.code!,
                  style: TextStyle(
                      color: color.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if(widget.complain!.voucherIssued!)
            const SizedBox(
              height: 10,
            ),
            if(widget.complain!.voucherIssued!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount Percentage: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.complain!.voucher!.percentage!}%",
                  style: TextStyle(
                      color: color.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if(widget.complain!.voucherIssued!)
            const SizedBox(
              height: 10,
            ),
            if(widget.complain!.voucherIssued!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Minimum Amount: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "RS ${widget.complain!.voucher!.min_amount}",
                  style: TextStyle(
                      color: color.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if(widget.complain!.voucherIssued!)
            const SizedBox(
              height: 10,
            ),
            if(widget.complain!.voucherIssued!)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Valid Until: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.complain!.voucher!.expiry!.day}-${widget.complain!.voucher!.expiry!.month}-${widget.complain!.voucher!.expiry!.year}",
                  style: TextStyle(
                      color: color.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
      ],
    );
  }

  Widget ratingTileM(fontsize, starsize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Customer Satisfaction: ',
          style: TextStyle(
            color: Colors.black,
            fontSize: fontsize,
                    fontWeight: FontWeight.bold
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: RatingStars(
            value: widget.complain!.rating!,
            // onValueChanged: (v) {
            //   print(v);
            //   x=v;
            //   setState(() {
                
            //   });
            // },
            starBuilder: (index, color) => Icon(
              Icons.star,
              color: color,
            ),
            starCount: 5,
            starSize: starsize,
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
            valueLabelPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            valueLabelMargin: const EdgeInsets.only(right: 8),
            starOffColor: const Color(0xffe7e8ea),
            starColor: Colors.yellow,
          ),
        ),
      ],
    );
  }

  Future rateAResolution() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: AlertDialog(
                elevation: 0,
                title: Text(
                  "Rate Your Experince",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                content: Container(
                  // width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rate Your Experince Out of 5, 5 being best and 1 being worst",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: RatingStars(
                    value: rating,
                    onValueChanged: (v) {
                      rating = v;
                      setState(() {});
                    },
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                    ),
                    starCount: 5,
                    starSize: 30,
                    valueLabelColor: const Color(0xff9b9b9b),
                    valueLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    valueLabelRadius: 10,
                    maxValue: 5,
                    starSpacing: 2.5,
                    maxValueVisibility: true,
                    valueLabelVisibility: true,
                    animationDuration: Duration(milliseconds: 1000),
                    valueLabelPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    valueLabelMargin: const EdgeInsets.only(right: 8),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  ),
                ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: color.purple),
                    ),
                    onPressed: () async {
                      if (rating != 0.0) {
                        
                      } else {
                        
                          Fluttertoast.showToast(
                              msg: 'Give Rating first.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: color.purple),
                    ),
                    onPressed: () async {
                      rating = 0.0;
                      Navigator.pop(context);
                      return;
                    },
                  )
                ],
              ),
            );
          }
        );
      },
    );
  }
}