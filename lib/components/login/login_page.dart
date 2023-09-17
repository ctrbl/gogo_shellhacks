import 'package:flutter/material.dart';
import 'package:gogo/components/common/custom_input_field.dart';
import 'package:gogo/components/common/page_header.dart';
import 'package:gogo/components/login/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gogo/components/common/page_heading.dart';
import 'package:gogo/components/common/custom_form_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gogo/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override 
  void dispose() {
    emailController.dispose();
    passwordController.dispose();    
    super.dispose(); 
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: Column(
            children: [
              const PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          const PageHeading(title: 'Log-in',),
                          CustomInputField(
                            controller: emailController,
                            labelText: 'Email',
                            hintText: 'Your email address',
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if(!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }
                          ),
                          const SizedBox(height: 16,),
                          CustomInputField(
                            controller: passwordController,
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Password is required!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          const SizedBox(height: 20,),
                          CustomFormButton(innerText: 'Login', onPressed: _handleLoginUser,),
                          const SizedBox(height: 18,),
                          SizedBox(
                            width: size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()))
                                  },
                                  child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18,),
                          SizedBox(
                            width: size.width * 0.9, 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Or login with', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18,),
                          GestureDetector(
                            onTap: () {
                              AuthService().signInWithGoogle();
                            },
                            child: const Image(width: 100, image: AssetImage('assets/images/google.png'))
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> _handleLoginUser() async {
    // login user
    try {
      if (_loginFormKey.currentState!.validate()) {
        final auth = FirebaseAuth.instance; 
        await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text,);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your email address or password is wrong.')),
      );
    }
  }
}