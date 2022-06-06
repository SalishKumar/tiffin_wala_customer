import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;

class ComplainTimeline extends StatefulWidget {
  const ComplainTimeline({ Key? key }) : super(key: key);

  @override
  State<ComplainTimeline> createState() => _ComplainTimelineState();
}

class _ComplainTimelineState extends State<ComplainTimeline> {
  bool dicriptionLess = true;
  bool resolutionLess = true;
  String expandDiscription = 'See more';
  String expandResoutionl = 'See more';
  double x = 3.5;

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
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
              complainTileM(16.0),
              SizedBox(height: 20,),
              const Text(
                  'Resolution',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
              resolutionTileM(16.0),
              SizedBox(height: 20,),
              const Text(
                  'Rating',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
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
      child: Expanded(
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
                  "123",
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
                  "Customer 1",
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
                  "ABC Kitchen",
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
                  "Resolved",
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
      ),
    );
  }

  Widget complainTileM(fontsize) {
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
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
              images: [
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                NetworkImage(
                    'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              ],
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
            Column(
              children: [
                Text(
                  'Resolution',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontsize,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  'by Chef: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontsize,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          
        resolutionLess
            ? Expanded(
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
            value: x,
            onValueChanged: (v) {
              print(v);
              x=v;
              setState(() {
                
              });
            },
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
}