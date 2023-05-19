import 'package:flutter/material.dart';
import 'package:sqflite_internship/screens/todo_product.dart';

import 'login_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum gender { male, female }

class _RegisterPageState extends State<RegisterPage> {
  bool showpassword = true;
  bool confirmpassword = true;
  bool checkvalue = true;
  var gendervalue = gender.male;

  void togglepassword() {
    setState(() {
      showpassword = !showpassword;
    });
  }

  void toggle_confirm_password() {
    setState(() {
      confirmpassword = !confirmpassword;
    });
  }

  var fnameController = TextEditingController();
  var lnameContoller = TextEditingController();
  var emailController = TextEditingController();
  var pssdContoller = TextEditingController();
  var confirmpssdController = TextEditingController();

  var fname='', lname="", email='', pssd='', confirmpssd='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Hey there,',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Create an Account',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: fnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text('First Name'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: lnameContoller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text('Last Name'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Gender'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                    child: Radio(
                      value: gender.male,
                      groupValue: gendervalue,
                      onChanged: (value) {
                        setState(() {
                          gendervalue = gender.male;
                        });
                      },
                    ),
                  ),
                  Text("Male"),
                  Radio(
                    value: gender.female,
                    groupValue: gendervalue,
                    onChanged: (value) {
                      setState(() {
                        gendervalue = gender.female;
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text('Email'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: pssdContoller,
                  obscureText: showpassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text(
                      'Password',
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        togglepassword();
                      },
                      child: showpassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: confirmpssdController,
                  obscureText: confirmpassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    label: Text('Confirm Password'),
                    suffixIcon: InkWell(
                      onTap: () {
                        toggle_confirm_password();
                      },
                      child: confirmpassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: checkvalue,
                      onChanged: (value) {
                        setState(() {
                          checkvalue = !checkvalue;
                        });
                      },
                    ),
                    SizedBox(
                        width: 320,
                        child: Text(
                            'By creating an account, you agree to our Conditions of Use and Privacy Notice')),
                  ],
                ),
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    onPressed: (
                        ) {
                      setState(() {
                        fname = fnameController.text;
                        lname = lnameContoller.text;
                        email = emailController.text;
                        pssd = pssdContoller.text;
                        confirmpssd = confirmpssdController.text;

                        if (fname.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter First Name'))
                          );
                        }
                        else if(lname.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter Second Name'))
                          );
                        }
                        else if(email.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please enter Email'))
                          );
                        }
                        else if(pssd.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please enter your Password'))
                          );
                        }
                        else if(confirmpssd.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please confirm your Password'))
                          );
                        }

                        else if(confirmpssd != pssd){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password must be same'))
                          );
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductRecord(),));
                        }
                      });
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Login+',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Already have an account?'),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    }, child: Text('Login'))
                  ],
                ),
              ),

            ],
          
          ),
        ],
      ),
    );
  }
}
