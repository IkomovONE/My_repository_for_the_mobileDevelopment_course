import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chumtalk/Login.dart';
import 'package:chumtalk/Register.dart';




class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black12,
          accentColor: Color(0xfff6893e),
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),

        ),
        home: Scaffold(

          backgroundColor: Colors.black12,


          body: Fields(),
        ));
  }
}



  class Fields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Container(

                height: 100,
                width: 250,


              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff6893e), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),


              child: RaisedButton(


                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).primaryColor,
                child: const Text("Join ChumTalk", style: TextStyle(color: Color(0xfff6893e), fontWeight: FontWeight.bold, fontSize: 25),),
                onPressed: () {Navigator.of(context).push(RouteToRegister());},
              ),
            ),

            SizedBox(height: 40),

            Container(

              height: 100,
              width: 250,


              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff6893e), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),


              child: RaisedButton(


                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).primaryColor,
                child: const Text("Log in", style: TextStyle(color: Color(0xfff6893e), fontWeight: FontWeight.bold, fontSize: 25),),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(RouteToLogin(),

                        (Route<dynamic> route) => false,);

                },
              ),
            ),


          ],
        ),
      );



  }
}

Route RouteToLogin() {
  var curve = Curves.ease;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Login(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(4.0, 6.0);
      const end = Offset.zero;
      var tweeen = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tweeen),
        child: child,
      );

      //https://docs.flutter.dev/cookbook/animation/page-route-animation
    },
  );
}

Route RouteToRegister() {
  var curve = Curves.ease;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Register(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(4.0, 6.0);
      const end = Offset.zero;
      var tweeen = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tweeen),
        child: child,
      );

      //https://docs.flutter.dev/cookbook/animation/page-route-animation
    },
  );
}
