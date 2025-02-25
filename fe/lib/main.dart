
import 'package:fe/views/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  // await dotenv.load(fileName: ".env");
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      ScreenUtilInit(
        designSize: const Size(375, 812), // iPhone 12
        child: SizedBox(
          width: kIsWeb?600:double.infinity,
          child: MaterialApp(

            debugShowCheckedModeBanner: false,
            title: 'Match My Resume',
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            home: HomeScreen(),

          ),
        ),
      );
  }
}
