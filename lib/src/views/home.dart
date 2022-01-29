import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/view_model/home_view_model.dart';
import 'package:tiffin_wala_customer/src/views/addresses.dart';
import 'package:tiffin_wala_customer/src/views/filter.dart';
import 'package:tiffin_wala_customer/src/views/login.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/views/menu.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    final storage = new FlutterSecureStorage();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: color.purple,
                  ),
                  child: Center(
                    child: Text(
                      data.user.name!,
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
                ListTile(
                  title: const Text(
                    'My Addresses',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Addresses.routeName);
                  },
                ),
                ListTile(
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () async {
                    await storage.deleteAll();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, Login.routeName);
                  },
                ),
              ],
            ),
          ),
          backgroundColor: color.background,
          appBar: AppBar(
            title: Text(
              "Tiffin Wala",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: color.purple,
            centerTitle: true,
            elevation: 0,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: AutoSizeText(
                    "One-Time Orders",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    "Subscription",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    "Custom Orders",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Consumer<HomeViewModel>(
                      builder: (context, homeViewModel, child) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          MyCustomTextfield(
                            size: 50,
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
                                return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Menu.routeName);
                                    },
                                    child: vendorDisplay(width));
                              }),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Consumer<HomeViewModel>(
                      builder: (context, homeViewModel, child) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          MyCustomTextfield(
                            size: 50,
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
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Consumer<HomeViewModel>(
                      builder: (context, homeViewModel, child) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          MyCustomTextfield(
                            size: 50,
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
              ),
            ],
          )),
    );
  }

  Widget vendorDisplay(width) {
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 8,
          color: color.textFieldFillColor,
          // child: Container(
          //   decoration:
          //       BoxDecoration(borderRadius: BorderRadius.circular(20)),
          //   padding: EdgeInsets.all(20),
          //   width: width,
          //   // height: 250,
          //   child: Column(
          //     children: [
          //       Text(
          //         'title',
          //         style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.w600,
          //             color: Color(0xFF24243e)),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
          //         child: Divider(
          //           thickness: 3,
          //           color: Colors.grey[300],
          //         ),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Card(
          //             // child: CachedNetworkImage(
          //             //   imageUrl: "https://darat.pythonanywhere.com/" +
          //             //       searchlist[index].logo,
          //             //   imageBuilder: (context, imageProvider) => Container(
          //             //     height: 125,
          //             //     width: 125,
          //             //     decoration: BoxDecoration(
          //             //       image: DecorationImage(
          //             //         image: imageProvider,
          //             //         fit: BoxFit.fill,
          //             //       ),
          //             //     ),
          //             //   ),
          //             // placeholder: (context, url) =>
          //             //     Center(child: CircularProgressIndicator()),
          //             // errorWidget: (context, url, error) =>
          //             //     Icon(Icons.error),
          //             child: Container(
          //               height: 125,
          //               width: 125,
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   image: AssetImage('assets/images.jpg'),
          //                   fit: BoxFit.fill,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             height: 100,
          //             // padding: EdgeInsets.symmetric(vertical: 20),
          //             child: VerticalDivider(
          //               color: Colors.grey[400],
          //               thickness: 2,
          //             ),
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Container(
          //                 width: width / 4,
          //                 child: AutoSizeText(
          //                   'Rating',
          //                   overflow: TextOverflow.ellipsis,
          //                   maxLines: 1,
          //                   style: TextStyle(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.w600,
          //                       color: Color(0xFF24243e)),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 10,
          //               ),
          //               Row(
          //                 children: [
          //                   Icon(
          //                     Icons.location_on_rounded,
          //                     size: 17,
          //                   ),
          //                   Container(
          //                     width: width / 5,
          //                     margin: EdgeInsets.only(left: 0),
          //                     child: Text(
          //                       'Karachi',
          //                       overflow: TextOverflow.ellipsis,
          //                     ),
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: width * 0.4,
                      width: width * 0.85,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images.jpg'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.favorite_border_rounded,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Featured",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: color.purple,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Rating',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
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
