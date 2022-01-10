import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/view_model/home_view_model.dart';
import 'package:tiffin_wala_customer/src/views/filter.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff152746),
                ),
                child: Center(
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'My Orders',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'My Vouchers',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'My Profile',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: color.background,
        appBar: AppBar(
          title: Text(
            "Tiffin Wala",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: color.purple,
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Consumer<HomeViewModel>(
                builder: (context, homeViewModel, child) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    MyCustomTextfield(
                      controller: homeViewModel.searchController,
                      textInputType: TextInputType.text,
                      onPressed: () {
                        Navigator.pushNamed(context, Filter.routeName);
                        // Navigator.of(context).pushReplacementNamed(Filter.routeName);

                      },
                      hintText: "Search",
                      error: '',
                      prefix: Icons.search,
                      onValidation: () {
                        homeViewModel.search();
                      },
                      suffix: Icons.list,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return vendorDisplay(width);
                        }),
                  ],
                ),
              );
            }),
          ),
        ));
  }

  Widget vendorDisplay(width) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 8,
            color: color.textFieldFillColor,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(20),
              width: width,
              // height: 250,
              child: Column(
                children: [
                  Text(
                    'title',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF24243e)),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Divider(
                      thickness: 3,
                      color: Colors.grey[300],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        // child: CachedNetworkImage(
                        //   imageUrl: "https://darat.pythonanywhere.com/" +
                        //       searchlist[index].logo,
                        //   imageBuilder: (context, imageProvider) => Container(
                        //     height: 125,
                        //     width: 125,
                        //     decoration: BoxDecoration(
                        //       image: DecorationImage(
                        //         image: imageProvider,
                        //         fit: BoxFit.fill,
                        //       ),
                        //     ),
                        //   ),
                        // placeholder: (context, url) =>
                        //     Center(child: CircularProgressIndicator()),
                        // errorWidget: (context, url, error) =>
                        //     Icon(Icons.error),
                        child: Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        child: VerticalDivider(
                          color: Colors.grey[400],
                          thickness: 2,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width / 4,
                            child: AutoSizeText(
                              'Rating',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF24243e)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 17,
                              ),
                              Container(
                                width: width / 5,
                                margin: EdgeInsets.only(left: 0),
                                child: Text(
                                  'Karachi',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
