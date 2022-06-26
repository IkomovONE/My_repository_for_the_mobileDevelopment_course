import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chumtalk/Message.dart';
import 'package:intl/intl.dart';






class Chat extends StatefulWidget {
  String messageContext= "";
  String GroupName= "";



  Chat({

    required this.GroupName,

  });


  ChatState createState() => new ChatState(GroupName: GroupName);
}

class ChatState extends State<Chat> {




  String messageContext= "";
  String GroupName= "";
  int number= 0;


  ChatState({

    required this.GroupName,

  });



  final TextEditingController _textController = new TextEditingController();

  getCount() async {
    await FirebaseFirestore.instance.collection("Groups").doc("$GroupName").collection("Count").doc("Count").get().then((DocumentSnapshot doc) {
      String count = doc.data().toString();
      try {
        number = int.parse(count.substring(11, 13));
      }
      catch (FormatException) {
        number = int.parse(count.substring(11, 12));
      }


      print(number);
    });
  }



  @override
  Widget build(BuildContext context) {
    getCount();

    return  WillPopScope(
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
      resizeToAvoidBottomInset: true,


      backgroundColor: Colors.black12,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),

          child: AppBar(

            title: Container(

              padding: EdgeInsets.all(8),


              decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff6893e), width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(15)),),




              child: Text(GroupName, style: TextStyle(color: Color(0xfff6893e), fontSize: 15, fontWeight: FontWeight.bold,),),
            ),



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
                        onPressed: () => Navigator.pop(context),

                        icon: const Icon(Icons.arrow_back_ios, size: 25, color: Color(0xfff6893e),),
                        label: const Text('Back', style: TextStyle(color: Color(0xfff6893e), fontSize: 17, fontWeight: FontWeight.bold,),),

                        style: ElevatedButton.styleFrom(
                            elevation: 0, primary: Colors.transparent),
                      )
                  ),







                  ))),




      body:

          Align(

            alignment: Alignment.bottomCenter,

      child: Column(mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,


    children: <Widget>[

      SizedBox(height: 50,),



      Expanded(

        child: Container(



          color: Colors.black12,

          child: MessageBuilder(GroupId: GroupName),

        ),

      ),

      SizedBox(height: 20,),




      SingleChildScrollView(
              child: Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
             Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff6893e), width: 2),
          color: Colors.black12,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Align( alignment: Alignment.center,
          child: TextFormField(
            controller: _textController,

              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.dark,
              textCapitalization: TextCapitalization.sentences,



              onChanged: (message) {


                messageContext=message;
                getCount();


              },

              cursorColor: Color(0xfff6893e),
              cursorWidth: 7.0,
              decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

                  focusedBorder: InputBorder.none,
                  hintText: "Your message",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 20.0, fontStyle: FontStyle.normal)),),
      ),

            SizedBox(width: 15),


            Container(


                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfff6893e), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),),

                child: ElevatedButton(
                  onPressed: () {
                    getCount();


                    this.setState(() {
                      _textController.clear();
                    });

                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('kk:mm:ss (d MMM)').format(now);
                    //https://stackoverflow.com/questions/51696478/datetime-flutter



                    number= number+1;
                    String count= number.toString();



                    FirebaseFirestore.instance.collection("Groups").doc("$GroupName").collection("messages").doc("$count").set({"time": formattedDate.toString(), "message": messageContext, "userName": FirebaseAuth.instance.currentUser?.displayName });

                    FirebaseFirestore.instance.collection("Groups").doc("$GroupName").collection("Count").doc("Count").update({"DocCount": number});
                    getCount();







                  },

                  child: const Icon(Icons.send_outlined, size: 30, color: Color(0xfff6893e),),


                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.transparent),
                )
            )




          ])),

      SizedBox(height: 50,)


      ])),

    ),)));}







}

