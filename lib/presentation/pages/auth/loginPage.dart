import 'package:flutter/material.dart';
import 'package:message_app/common/util.dart';
import 'package:message_app/presentation/pages/auth/registerPage.dart';
import 'package:message_app/presentation/pages/main/homePage.dart';
import 'package:message_app/presentation/providers/authProvider.dart';
import 'package:message_app/presentation/widgets/customTextField.dart';
import 'package:message_app/presentation/widgets/primaryButton.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool obscureText = true;

  @override
  void initState() {
    // emailController.dispose();
    // passwordController.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 35),
                Text(
                  "HOLA AMIGO".toUpperCase(),
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    fontFamily: "nunito",
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 8,
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  child: Image.asset(
                    "assets/images/chat(1).png",
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      //email text field
                      CustomTextFormField(
                        isEmail: true,
                        emailController: emailController,
                        hintText: "Email",
                        icon: Icons.person,
                        iconColor: Theme.of(context).primaryColor,
                      ),

                      //password text field
                      SizedBox(height: 15),

                      TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "Password can't be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      PrimaryButton(
                        text: "Login",
                        borderRadius: 30,
                        loading: false,
                        textColor: Colors.white,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            bool status = await Provider.of<AuthProvider>(
                                    context,
                                    listen: false)
                                .loginUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            if (!status) {
                              showMessage(
                                  scaffoldKey: _scaffoldKey,
                                  title: "Email or password was wrong!");
                            } else {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false,
                              );
                            }
                          }
                        },
                        height: 50,
                        ml: 0,
                        mr: 0,
                        mb: 15,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          redirectTo(page: RegisterPage(), context: context);
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
