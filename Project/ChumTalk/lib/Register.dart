import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chumtalk/Loading.dart';
import 'package:chumtalk/Groups.dart';
import 'package:chumtalk/main_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  setCredentials createState() => setCredentials();

}

class setCredentials extends State {

  late String password= "";
  late String nickname= "";
  late String name= "";


  SetPassword(String value){
    setState(() {
      password= value;
    }
    );
  }

  SetNickname(String nick){
    setState(() {
      nickname= nick;
    }
    );
  }

  SetName(String nick){
    setState(() {
      name= nick;
    }
    );
  }



  @override
  Widget build(BuildContext context) {



    return WillPopScope(
        onWillPop: () async => false,
    child: GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },
    child: MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black12,
        accentColor: Color(0xfff6893e),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),

      home: Scaffold(

        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45.0),
            child: AppBar(

                backgroundColor: Colors.black12,


                automaticallyImplyLeading: false,
                leadingWidth: 200,
                leading: Align(
                    alignment: Alignment.centerRight,
                    child: Container(

                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xfff6893e), width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),),

                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MainPage()),

                                (Route<dynamic> route) => false,),
                          icon: const Icon(Icons.arrow_back_ios, size: 35, color: Color(0xfff6893e),),
                          label: const Text("Back", style: TextStyle(color: Color(0xfff6893e), fontSize: 20, fontWeight: FontWeight.bold,),),

                          style: ElevatedButton.styleFrom(
                              elevation: 0, primary: Colors.transparent),
                        )
                    )))),
        backgroundColor: Colors.black12,
        //the appBar back button is taken from "https://www.kindacode.com/snippet/flutter-creating-custom-back-buttons/"




      body: Center(

    child: Column(


          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,


          children: <Widget>[

            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfff6893e), width: 2),
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Align( alignment: Alignment.center,
                  child: TextFormField(

                      keyboardAppearance: Brightness.dark,

                      onChanged: (value) {

                        SetName(value);

                      },
                      cursorColor: Color(0xfff6893e),
                      cursorWidth: 7.0,


                      decoration: const InputDecoration(

                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

                          focusedBorder: InputBorder.none,
                          hintText: "New Nickname",
                          hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),),
              ),],),

            const SizedBox(height: 50),



            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
        Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff6893e), width: 2),
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Align( alignment: Alignment.center,
          child: TextFormField(

              keyboardAppearance: Brightness.dark,

              onChanged: (name) {

                SetNickname(name);


              },

              cursorColor: Color(0xfff6893e),
              cursorWidth: 7.0,



              decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

                  focusedBorder: InputBorder.none,
                  hintText: "New E-mail",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),),
      ), ]),

            const SizedBox(height: 50),



        Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff6893e), width: 2),
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Align( alignment: Alignment.center,
                child: TextFormField(

                    keyboardAppearance: Brightness.dark,

                    onChanged: (value) {

                      SetPassword(value);

                    },
                    cursorColor: Color(0xfff6893e),
                    cursorWidth: 7.0,
                    obscureText: true,

                    decoration: const InputDecoration(

                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "New Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),),
            ),],),

            const SizedBox(height: 80),




            Container(
              height: 50,
              width: 350,

              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff6893e), width: 2),

                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {

                    Auth().Register(nickname: nickname, password: password);


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Loading()),
                    );

                    Future<void> Check() async{

                      await Future<void>.delayed(Duration(seconds: 2), () {




                        if (FirebaseAuth.instance.currentUser != null) {

                          Navigator.of(context).push(RouteToGroups());
                          FirebaseAuth.instance.currentUser?.updateDisplayName(name);

                        }

                        else {

                          Navigator.pop(context);
                          showAlertDialog(context);

                          print("Not signed in");
                        }

                      });
                    }


                    Check();



                  },
                  child: const Text("Register",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Color(0xfff6893e),
                        fontSize: 25.0,
                        fontStyle: FontStyle.normal),
                  )),
            )







      ],
      ),)),






    ),));







  }


  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(


      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },


      child: Text("OK", style: TextStyle(color: Color(0xfff6893e),
          fontSize: 25,
          fontWeight: FontWeight.bold),),);


    AlertDialog alert = AlertDialog(


        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),

            side: BorderSide(color: Color(0xfff6893e),)),


        backgroundColor: Colors.black,


        title: const Text("Wrong credentials!", style: TextStyle(
            color: Color(0xfff6893e),
            fontWeight: FontWeight.bold,
            fontSize: 20),),

        actions: [

          okButton,

        ]
    );


    showDialog(

        context: context,

        builder: (BuildContext context) {
          return alert;
        }


    );
  }

  }


class Auth {

  Future<String> Register({required String nickname, required String password}) async{

    late final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
    try{



      _firebaseAuth.createUserWithEmailAndPassword(email: nickname, password: password);


      return "Signed in";
    }
    on FirebaseAuthException {
      return "Error";
    }
  }
}




Route RouteToGroups() {
  var curve = Curves.ease;
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  Groups(),
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