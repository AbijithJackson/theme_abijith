import 'package:flutter/material.dart';
import 'package:sqflite_internship/screens/registeration_page.dart';
import 'package:sqflite_internship/screens/todo_product.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool loginpssd = true;
  
  var emailController = TextEditingController();
  var pssdController = TextEditingController();
  
  var email='', pssd='';
  
  void toggle_pssd(){
    setState(() {
      loginpssd = !loginpssd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text('Username or Email')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: pssdController,
                obscureText: loginpssd,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    label: Text('Password'),
                suffixIcon: InkWell(
                  onTap: (){
                    toggle_pssd();
                  },
                  child: loginpssd? Icon(Icons.visibility) : Icon(Icons.visibility_off)
                )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [

                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                  },
                      child: Text('Create account'))
                ],
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(onPressed: () {

                setState(() {

                  email = emailController.text;
                  pssd = pssdController.text;

                  if(email.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter your Email'))
                    );
                  }
                  else if(pssd.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter your Password'))
                    );
                  }
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductRecord(),));
                  }

                });

              }, child: Text('Login')),
            )
          ],
        ),
      ],
      ),
    );
  }
}
