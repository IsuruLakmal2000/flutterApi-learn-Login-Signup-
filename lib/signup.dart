// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:loginapp/httpHandler/networkHandler.dart';
import 'package:loginapp/login.dart';
import 'package:loginapp/main.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  //String errorText;
  bool validate = false;
  bool Circular = false;

  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create new account",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/sss.png'),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                child: Column(
                  children: <Widget>[
                    makeInputName(label: "Email"),
                    makeInputPassword(label: "Password"),
                    makeInputCpassword(label: "Confirm Password"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  ),
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  //// On pressed method
                  onPressed: () {
                    if (_errorTextName == null &&
                        _errorTextPassword == null &&
                        _errorTextCpassword == null) {
                      print("inside signup");
                      Map<String, String> data = {
                        "username": _controller.text,
                        "password": _controller2.text,
                        "cpassword": _controller3.text,
                      };
                      print(data);
                      networkHandler.post("/user/register", data);
                    }
                  },
                  color: Colors.yellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Do you already have an account?"),
                TextButton(
                  // On pressed method
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }),
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget makeInputName({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        TextField(
          controller: _controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorText: _errorTextName,
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget makeInputPassword({label, obscureText = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        TextField(
          controller: _controller2,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorText: _errorTextPassword,
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget makeInputCpassword({label, obscureText = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        TextField(
          controller: _controller3,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorText: _errorTextCpassword,
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  String? get _errorTextName {
    final text = _controller.value.text;
    if (text.isEmpty) {
      return 'Cant be empty!';
    }
    if (!text.contains("@")) {
      return 'Email not valid!';
    }
    return null;
  }

  String? get _errorTextPassword {
    final text = _controller2.value.text;
    if (text.isEmpty) {
      return 'Cant be empty!';
    }
    if (text.length < 4) {
      return 'Password contains atleast 4 characters!';
    }
    return null;
  }

  String? get _errorTextCpassword {
    final text = _controller3.value.text;
    if (text.isEmpty) {
      return 'Cant be empty!';
    }
    if (text != _controller2.value.text) {
      return 'Password not match!';
    }
    return null;
  }

  // checkUser( ) async{
  //   if(_controller.text.isEmpty){
  //     setState(() {
  //       validate = false;
  //       errorText = "Username cannot be empty";
  //     });
  //   }else{
  //     setState((){
  //       validate = false;
  //       errorText = "Username already exists";
  //     });
  //   }else{
  //     var response = await networkHandler.get("/user/checkusername/${_controller.text}");
  //     if(response["status"]){
  //       setState((){
  //         validate =false;
  //         errorText = "Username already exists";
  //       }else{
  //         validate =true;
  //       });
  //   }});
  // }
}
