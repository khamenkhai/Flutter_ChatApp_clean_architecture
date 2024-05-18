import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message_app/firebase_options.dart';
import 'package:message_app/injection_container.dart' as ic;
import 'package:message_app/presentation/pages/auth/loginPage.dart';
import 'package:message_app/common/theme.dart';
import 'package:message_app/presentation/pages/main/homePage.dart';
import 'package:message_app/presentation/providers/authProvider.dart';
import 'package:message_app/presentation/providers/messageProvider.dart';
import 'package:message_app/presentation/providers/userProvider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ic.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ic.getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (context)=>ic.getIt<UserProvider>()),
        ChangeNotifierProvider(create: (context)=>ic.getIt<MesssageProvider>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkGrey,
        debugShowCheckedModeBanner: false,
        home: Consumer<AuthProvider>(  
          builder: (context, value, child) {
            if(value.currentUser == null){
              return LoginScreen();
            }else{
              // Provider.of<UserProvider>(context,listen: false).getCurrentUser();
              return HomePage();
            }
          },
        ),
      ),
    );
  }
}
