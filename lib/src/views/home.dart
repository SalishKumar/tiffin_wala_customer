import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/routes.dart';
import 'package:tiffin_wala_customer/src/view_model/home_view_model.dart';
import 'package:tiffin_wala_customer/src/views/second.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    return Scaffold(
        appBar:AppBar(),
        body: Center(child: Consumer<HomeViewModel>(
          builder: (context,homeViewModel,child) {
            return Text(homeViewModel.count.toString());
          }
        ),),
        floatingActionButton: FloatingActionButton(onPressed: (){
          // homeViewModel.increamentCount();
          Navigator.of(context).pushNamed(Second.routeName);
        },child: Icon(Icons.add),),
      );
  }
}
