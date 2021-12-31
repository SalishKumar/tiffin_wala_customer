import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffin_wala_customer/src/routes.dart';
import 'package:tiffin_wala_customer/src/view_model/home_view_model.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel =
    Provider.of<HomeViewModel>(context, listen: false);
    return MaterialApp(
      onGenerateRoute: generateRoute,

      home:  Scaffold(
        appBar:AppBar(),
        body: Center(child: Consumer<HomeViewModel>(
          builder: (context,homeViewModel,child) {
            return Text(homeViewModel.count.toString());
          }
        ),),
        floatingActionButton: FloatingActionButton(onPressed: (){
          homeViewModel.increamentCount();
        },child: Icon(Icons.add),),
      ),
    );
  }
}
