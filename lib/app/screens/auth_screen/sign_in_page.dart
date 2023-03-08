
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internship_task/app/screens/auth_screen/sign_up_page.dart';
import 'package:internship_task/app/services/firebase.dart';

import '../../utils/theme_helper.dart';
import '../../widgets/header_widget.dart';
import '../home_screen/home_page.dart';

class SignInPage extends StatefulWidget{
  const SignInPage({Key? key}): super(key:key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      const Text(
                        'Hello',
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'SignIn into your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShadow(),
                                child: TextFormField(
                                  validator: (val) {
                                    if(val!.isEmpty){
                                      return "Don't leave empty entry";
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your email'),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                decoration: ThemeHelper().inputBoxDecorationShadow(),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: (val) {
                                    if(val!.isEmpty){
                                      return "Don't leave empty entry";
                                    }
                                    return null;
                                  },
                                  decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,0,10,20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                  },
                                  child: const Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Sign In'.toUpperCase(),
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),

                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()){
                                      bool isValidLogin = await FirebaseFireStore.to.handleSignIn(emailController.text, passwordController.text);
                                      if(isValidLogin){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                                      }else {
                                        Fluttertoast.showToast(
                                            msg: "Invalid Credentials",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.grey[300],
                                            textColor: Colors.black,
                                            fontSize: 16.0
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          const TextSpan(text: "Don't have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }
}