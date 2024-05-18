import 'package:flutter/material.dart';
import 'package:message_app/common/util.dart';
import 'package:message_app/domain/entities/userEntity.dart';
import 'package:message_app/presentation/providers/authProvider.dart';
import 'package:message_app/presentation/widgets/customTextField.dart';
import 'package:message_app/presentation/widgets/primaryButton.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool obscureText = true;

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
                SizedBox(height: 40),
                Container(
                  child: Image.asset(
                    "assets/images/message.png",
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      //name text field
                      CustomTextFormField(
                        emailController: nameController,
                        hintText: "Username",
                        icon: Icons.person,
                        iconColor: Theme.of(context).primaryColor,
                      ),

                      //phone number text field
                      SizedBox(height: 15),
                      CustomTextFormField(
                        emailController: phoneController,
                        hintText: "Phone No.",
                        icon: Icons.phone,
                        iconColor: Theme.of(context).primaryColor,
                      ),

                      //email text field
                      SizedBox(height: 15),
                      CustomTextFormField(
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
                          if (value == null || value == "") {
                            return " Password can't be empty!";
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
                                  : Icons.visibility_off)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      Consumer<AuthProvider>(builder: (context, value, child) {
                        return value.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : PrimaryButton(
                                text: "Register",
                                borderRadius: 30,
                                loading: false,
                                textColor: Colors.white,
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (passwordController.text.length <= 6) {
                                      showMessage(
                                          scaffoldKey: _scaffoldKey,
                                          title:
                                              "Password length should be longer than 6");
                                    } else {
                                      bool status =
                                          await Provider.of<AuthProvider>(
                                                  context,
                                                  listen: false)
                                              .register(
                                        UserEntity(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );

                                      if (!status) {
                                        nameController.clear();
                                        phoneController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                                      }
                                    }
                                  }
                                },
                                height: 50,
                                ml: 0,
                                mr: 0,
                                mb: 15,
                              );
                      }),

                      // PrimaryButton(
                      //   text: "Register",
                      //   borderRadius: 30,
                      //   loading: false,
                      //   textColor: Colors.white,
                      //   onTap: () async {
                      //     if (_formKey.currentState!.validate()) {
                      //       if (passwordController.text.length <= 6) {
                      //         showMessage(
                      //             scaffoldKey: _scaffoldKey,
                      //             title:
                      //                 "Password length should be longer than 6");
                      //       } else {
                      //         bool status = await Provider.of<AuthProvider>(
                      //                 context,
                      //                 listen: false)
                      //             .register(
                      //           UserEntity(
                      //             name: nameController.text,
                      //             phone: phoneController.text,
                      //             email: emailController.text,
                      //             password: passwordController.text,
                      //           ),
                      //         );

                      //         if (!status) {
                      //           nameController.clear();
                      //           phoneController.clear();
                      //           emailController.clear();
                      //           passwordController.clear();
                      //         }
                      //       }
                      //     }
                      //   },
                      //   height: 50,
                      //   ml: 0,
                      //   mr: 0,
                      //   mb: 15,
                      // )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          //navigate to login screen
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
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
