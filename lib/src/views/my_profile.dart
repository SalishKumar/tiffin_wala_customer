import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:string_validator/string_validator.dart';
import 'package:tiffin_wala_customer/src/constants/color.dart' as color;
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield.dart';
import 'package:tiffin_wala_customer/src/constants/my_custom_textfield_without_suffix.dart';
import 'package:tiffin_wala_customer/src/models/user.dart';
import 'package:tiffin_wala_customer/src/constants/data.dart' as data;
import 'package:tiffin_wala_customer/src/service/database.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController editInfo = TextEditingController(),
      editInfo1 = TextEditingController();
  late User1 user1;
  Database db = Database();
  final storage = FlutterSecureStorage();
  bool obsecure1 = true, obsecure2 = true;
  IconData suffix1 = Icons.remove_red_eye, suffix2 = Icons.remove_red_eye;

  @override
  void initState() {
    user1 = data.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
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
          margin: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
          child: Column(
            children: [
              Container(
                width: width * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user1.name!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              dilogueBox("Edit Name", "Enter Name to Edit",
                                  "Name", TextInputType.name, 20);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: color.purple,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              user1.google?SizedBox(): Container(
                width: width * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user1.email!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              dilogueBox("Edit Email", "Enter Email to Edit",
                                  "example@gmail.com", TextInputType.emailAddress, 50);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: color.purple,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              user1.google?SizedBox(): Container(
                width: width * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),Text(
                                    '********',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async{
                              
                                await editPass("Edit Password",
                                  "Enter Password to Edit",
                                  "Old Password",
                                  "New Password",
                                  TextInputType.visiblePassword,
                                  20);
                              
                            },
                            icon: Icon(
                              Icons.edit,
                              color: color.purple,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: width * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user1.phone!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              dilogueBox(
                                  "Edit Phone Number",
                                  "Enter Phone Number to Edit",
                                  "03xxxxxxxxx",
                                  TextInputType.phone,
                                  11);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: color.purple,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future dilogueBox(header, msg, hint, type, size) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: AlertDialog(
            elevation: 0,
            title: Text(
              header,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Container(
              // width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyCustomTextfieldWithoutSuffix(
                    size: size,
                    width: MediaQuery.of(context).size.width * 0.9,
                    textInputType: type,
                    prefix: Icons.phone,
                    hintText: hint,
                    error: '',
                    controller: editInfo,
                    lines: 1,
                    onValidation: () {},
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  if (header == "Edit Name") {
                    await editName();
                  } else if (header == "Edit Email") {
                    await editEmail();
                  } else if (header == "Edit Phone Number") {
                    await editPhone();
                  }
                },
              ),
              TextButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: color.purple),
                ),
                onPressed: () async {
                  editInfo.clear();
                  Navigator.pop(context);
                  return;
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future editPass(header, msg, hint1, hint2, type, size) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: AlertDialog(
                elevation: 0,
                title: Text(
                  header,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                content: Container(
                  // width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyCustomTextfield(
                        size: 20,
                        disable: true,
                        onValidation: () {},
                        controller: editInfo,
                        textInputType: TextInputType.visiblePassword,
                        onPressed: () {
                          obsecure1 = !obsecure1;
                          if (obsecure1) {
                            suffix1 = Icons.visibility;
                          } else {
                            suffix1 = Icons.visibility_off;
                          }
                        },
                        hintText: hint1,
                        label: hint1,
                        error: '',
                        prefix: Icons.lock,
                        obscureText: obsecure1,
                        suffix: suffix1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyCustomTextfield(
                        size: 20,
                        disable: true,
                        onValidation: () {},
                        controller: editInfo1,
                        textInputType: TextInputType.visiblePassword,
                        onPressed: () {
                          obsecure2 = !obsecure2;
                          if (obsecure2) {
                            suffix2 = Icons.visibility;
                          } else {
                            suffix2 = Icons.visibility_off;
                          }
                        },
                        hintText: hint2,
                        label: hint2,
                        error: '',
                        prefix: Icons.lock,
                        obscureText: obsecure2,
                        suffix: suffix2,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: color.purple),
                    ),
                    onPressed: () async {
                      String pattern = r'^(?=.*[a-zA-Z])(?=.*[0-9])[a-z0-9A-Z]+$';
                      RegExp regExp = new RegExp(pattern);
                      bool isValid1 = regExp.hasMatch(editInfo.text.trim());
                      bool isValid2 = regExp.hasMatch(editInfo1.text.trim());

                      if (isValid1 &&
                          isValid2 &&
                          editInfo.text.trim().isNotEmpty &&
                          editInfo.text.trim().length > 5 &&
                          editInfo1.text.trim().isNotEmpty &&
                          editInfo1.text.trim().length > 5) {
                        Map<String, dynamic> map = {
                          'field_type': 'password',
                          'value': editInfo1.text.trim(),
                          'old_pass': editInfo.text.trim(),
                          'customer_id': user1.id
                        };
                        // Navigator.pop(context);
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
                        dynamic result = await db.updteUser(map);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (result == null) {
                          Fluttertoast.showToast(
                              msg: 'Issue with connection. Try again later.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          if (result != null) {
                            if (result['Timeout'] == 'true') {
                              Fluttertoast.showToast(
                                  msg:
                                      'Your request has been timmed-out. Try again.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (result["status"]) {
                              await storage.write(key: 'password', value: 'input');
                              editInfo.clear();
                              setState(() {});
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
                        }
                      } else {
                        if (editInfo.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Old Password is Empty',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (editInfo.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'New Password is Empty',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (isValid1 == false) {
                          Fluttertoast.showToast(
                              msg:
                                  'Ensure that length of Password is 6 characters and should contain atleast one alphabet and one number.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (isValid2 == false) {
                          Fluttertoast.showToast(
                              msg:
                                  'Ensure that length of Password is 6 characters and should contain atleast one alphabet and one number.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (editInfo.text.trim().length <= 5) {
                          Fluttertoast.showToast(
                              msg: 'Old Password is too short.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (editInfo1.text.trim().length <= 5) {
                          Fluttertoast.showToast(
                              msg: 'New Password is too short.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: color.purple),
                    ),
                    onPressed: () async {
                      editInfo.clear();
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

  Future editName() async {
    bool isValid = true;
    List<String> tempName = editInfo.text.trim().split(" ");
    for (var name in tempName) {
      if (isAlpha(name) == false) {
        isValid = false;
        break;
      }
    }
    if (editInfo.text.trim().isNotEmpty &&
        isValid &&
        editInfo.text.trim() != user1.name) {
      Navigator.pop(context);
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
      Map<String, dynamic> map = {
        'field_type': "name",
        'value': editInfo.text.trim(),
        'customer_id': user1.id,
      };
      dynamic result = await db.updteUser(map);
      Navigator.pop(context);
      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
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
            user1.name = editInfo.text.trim();
            data.user = user1;
            await storage.write(key: 'name', value: user1.name);
            editInfo.clear();
            setState(() {});
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
      }
    } else {
      if (editInfo.text.trim().isEmpty) {
        Fluttertoast.showToast(
            msg: 'Name is Empty',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (isValid == false) {
        Fluttertoast.showToast(
            msg:
                'Format is incorrect. Please make sure there are only alphabets in name separated by space(s).',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (editInfo.text.trim() == user1.name) {
        Fluttertoast.showToast(
            msg: 'This is already name of this account.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future editEmail() async {
    bool isValid = isEmail(editInfo.text.trim());
    if (editInfo.text.trim().isNotEmpty &&
        isValid &&
        editInfo.text.trim() != user1.name) {
      Navigator.pop(context);
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
      // Map<String, dynamic> map = {
      //   'field_type': "email",
      //   'value': editInfo.text.trim(),
      //   'customer_id': user1.id,
      // };
      // dynamic result = await db.updteUser(map);
      Map<String, dynamic> map = {
        'update_method': "email",
        'data': editInfo.text.trim(),
      };
      dynamic result = await db.verifyForUpdate(map);
      Navigator.pop(context);
      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
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
            String code = result['code'].toString();
            TextEditingController codeEmail = TextEditingController();
            Fluttertoast.showToast(
                msg: result["message"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: AlertDialog(
                    elevation: 0,
                    title: Text(
                      'Verification',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    content: Container(
                      // width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          Text(
                            "Enter the Code sent to Email",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MyCustomTextfieldWithoutSuffix(
                            size: 6,
                            width: MediaQuery.of(context).size.width * 0.9,
                            textInputType: TextInputType.number,
                            prefix: Icons.phone,
                            hintText: 'Code For Email',
                            error: '',
                            controller: codeEmail,
                            lines: 1,
                            onValidation: () {},
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: color.purple),
                        ),
                        onPressed: () async {
                          if (codeEmail.text.trim().isNotEmpty) {
                            if (codeEmail.text.trim() == code) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              Map<String, dynamic> map = {
                                'field_type': "email",
                                'value': editInfo.text.trim(),
                                'customer_id': user1.id,
                              };
                              print(editInfo.text);
                              dynamic result = await db.updteUser(map);
                              Navigator.pop(context);
                              //Navigator.pop(context);
                              if (result != null) {
                                if (result['Timeout'] == 'true') {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Your request has been timmed-out. Try again.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }

                                if (result["status"]) {
                                  user1.email = editInfo.text.trim();
                                  data.user = user1;
                                  await storage.write(
                                      key: 'email', value: user1.email);
                                  editInfo.clear();
                                  setState(() {});
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: result["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: result["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        'Issue with connection. Try again later.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Code does not match.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            if (codeEmail.text.trim().isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Code is empty.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: color.purple),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          return;
                        },
                      )
                    ],
                  ),
                );
              },
            );
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
      }
    } else {
      if (editInfo.text.trim().isEmpty) {
        Fluttertoast.showToast(
            msg: 'Email is Empty',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (isValid == false) {
        Fluttertoast.showToast(
            msg: 'Format is incorrect.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (editInfo.text.trim() == user1.name) {
        Fluttertoast.showToast(
            msg: 'This is already Email of this account.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future editPhone() async {
    String pattern = r'^(?=.*?[0-9]).{11}$';
    RegExp regExp = new RegExp(pattern);
    bool isValid = regExp.hasMatch(editInfo.text.trim());
    if (editInfo.text.trim().isNotEmpty &&
        isValid &&
        editInfo.text.trim() != user1.name) {
      Navigator.pop(context);
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
      // Map<String, dynamic> map = {
      //   'field_type': "email",
      //   'value': editInfo.text.trim(),
      //   'customer_id': user1.id,
      // };
      // dynamic result = await db.updteUser(map);
      Map<String, dynamic> map = {
        'update_method': "phone",
        'data': editInfo.text.trim(),
      };
      dynamic result = await db.verifyForUpdate(map);
      Navigator.pop(context);
      if (result == null) {
        Fluttertoast.showToast(
            msg: 'Issue with connection. Try again later.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
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
            String code = result['code'].toString();
            TextEditingController codePhone = TextEditingController();
            Fluttertoast.showToast(
                msg: result["message"],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: AlertDialog(
                    elevation: 0,
                    title: Text(
                      'Verification',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    content: Container(
                      // width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: [
                          Text(
                            "Enter the Code sent to Phone Number",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MyCustomTextfieldWithoutSuffix(
                            size: 6,
                            width: MediaQuery.of(context).size.width * 0.9,
                            textInputType: TextInputType.number,
                            prefix: Icons.phone,
                            hintText: 'Code For Phone Number',
                            error: '',
                            controller: codePhone,
                            lines: 1,
                            onValidation: () {},
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "OK",
                          style: TextStyle(color: color.purple),
                        ),
                        onPressed: () async {
                          if (codePhone.text.trim().isNotEmpty) {
                            if (codePhone.text.trim() == code) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              Map<String, dynamic> map = {
                                'field_type': "phone",
                                'value': editInfo.text.trim(),
                                'customer_id': user1.id,
                              };
                              print(editInfo.text);
                              dynamic result = await db.updteUser(map);
                              Navigator.pop(context);
                              //Navigator.pop(context);
                              if (result != null) {
                                if (result['Timeout'] == 'true') {
                                  Fluttertoast.showToast(
                                      msg:
                                          'Your request has been timmed-out. Try again.',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }

                                if (result["status"]) {
                                  user1.phone = editInfo.text.trim();
                                  data.user = user1;
                                  await storage.write(
                                      key: 'phone', value: user1.email);
                                  editInfo.clear();
                                  setState(() {});
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg: result["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: result["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        'Issue with connection. Try again later.',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Code does not match.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            if (codePhone.text.trim().isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Code is empty.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: color.purple),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          return;
                        },
                      )
                    ],
                  ),
                );
              },
            );
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
      }
    } else {
      if (editInfo.text.trim().isEmpty) {
        Fluttertoast.showToast(
            msg: 'Phone Number is Empty',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (isValid == false) {
        Fluttertoast.showToast(
            msg: 'Format is incorrect.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (editInfo.text.trim() == user1.name) {
        Fluttertoast.showToast(
            msg: 'This is already Phone Number of this account.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
