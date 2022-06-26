import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:chumtalk/Groups.dart';
import 'package:firebase_auth/firebase_auth.dart';





class NewPassword extends StatelessWidget {

  String NewPass= "";

  SetPassword(String value){

      NewPass= value;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black12,
          accentColor: Color(0xfff6893e),
          textTheme: GoogleFonts.montserratTextTheme(
            Theme
                .of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),

        ),
        home: Scaffold(
          backgroundColor: Colors.black,


          appBar: PreferredSize(
              preferredSize: Size.fromHeight(45.0),

              child: AppBar(





                  backgroundColor: Colors.black12,


                  automaticallyImplyLeading: false,
                  leadingWidth: 200,
                  leading: Align(
                    alignment: Alignment.centerRight,
                    child:



                    Container(

                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xfff6893e), width: 2),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),),

                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Groups()),
                          ),

                          icon: const Icon(Icons.arrow_back_ios, size: 25, color: Color(0xfff6893e),),
                          label: const Text('Back', style: TextStyle(color: Color(0xfff6893e), fontSize: 17, fontWeight: FontWeight.bold,),),

                          style: ElevatedButton.styleFrom(
                              elevation: 0, primary: Colors.transparent),
                        )
                    ),







                  ))),


          body: Center(
            child: Container(



            height: 500,


              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [


                  Container(
    height: 300,
    width: 350,

    child: Align(alignment: Alignment.center,
    child: const Text("PASSWORD MUST BE AT LEAST 6 CHARACTERS LONG, OTHERWISE IT WON'T CHANGE",
      style: TextStyle(fontWeight: FontWeight.bold,
          color: Color(0xfff6893e),
          fontSize: 25.0,
          fontStyle: FontStyle.normal),))),




    Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xfff6893e), width: 2),
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Align(alignment: Alignment.center,
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
                              EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "New Password",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xfff6893e),
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.normal)),
                          style: const TextStyle(fontWeight: FontWeight.bold,
                              color: Color(0xfff6893e),
                              fontSize: 20.0,
                              fontStyle: FontStyle.normal)),),
                  ),


                  SizedBox(height: 50),



                  Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(5),




                    decoration: BoxDecoration(

                      border: Border.all(color: Color(0xfff6893e), width: 2),

                      borderRadius: const BorderRadius.all(const Radius.circular(15)),
                    ),
                    child: RaisedButton(
                        color: Colors.black,

                        onPressed: () {


                          FirebaseAuth.instance.currentUser!.updatePassword(NewPass);




                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Groups()),
                          );




                        },
                        child: const Text("Submit",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Color(0xfff6893e),
                              fontSize: 25.0,
                              fontStyle: FontStyle.normal),
                        )

                    ),
                  ),


    ],

              )


          )),
        ));
  }}