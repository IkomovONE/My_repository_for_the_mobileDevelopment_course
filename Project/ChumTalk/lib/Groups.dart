import 'dart:async';
import 'package:chumtalk/NewPassword.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chumtalk/Loading.dart';
import 'package:chumtalk/main_page.dart';
import 'package:chumtalk/Chat.dart';
import 'package:firebase_auth/firebase_auth.dart';


final Stream<QuerySnapshot> groups = FirebaseFirestore.instance.collection("Groups").snapshots();


final collection = FirebaseFirestore.instance.collection("Counter");
final _scrollController = FixedExtentScrollController();

int number= 0;
String group= "";







  class Groups extends StatefulWidget {


  @override
  GroupsState createState() => GroupsState();


  static getAllMessages(String groupId) {


    final Stream<QuerySnapshot> _Stream= FirebaseFirestore.instance.collection("Groups/$groupId/messages").orderBy("time", descending: true).snapshots();

    return _Stream;

  }

  }




  class GroupsState extends State {
    bool _isLoading = true;
    String names= "";

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    // this line is taken from Stack Overflow: https://stackoverflow.com/questions/47435231/open-drawer-on-clicking-appbar


    getCounter() async {
      await collection.doc("Counter").get().then((DocumentSnapshot doc) {
        String count = doc.data().toString();
        try {
          number = int.parse(count.substring(11, 13));
        }
        catch (FormatException) {
          number = int.parse(count.substring(11, 12));
        }



      });
    }




    void initState() {
      // TODO: implement initState
      super.initState();

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    }

//https://www.flutterbeads.com/flutter-delay-widgets/#future-delayed







    Widget build(BuildContext context) {
      getCounter();


      return WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.black12,
            accentColor: Colors.deepOrangeAccent,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme
                  .of(context)
                  .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
            ),

          ),
          home: Scaffold(
            key: _scaffoldKey,
              backgroundColor: Colors.black12,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: AppBar(
                      backgroundColor: Colors.black12,
                      automaticallyImplyLeading: false,


                      flexibleSpace: Align(
                        alignment: Alignment.bottomCenter,

                        child: Row(children: [

                          SizedBox(width: 300),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xfff6893e),
                                  width: 2),
                              borderRadius: const BorderRadius.all(Radius
                                  .circular(15)),),


                            child: ElevatedButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },

                                child: const Icon(
                                  FontAwesomeIcons.anglesRight, size: 40,
                                  color: Color(0xfff6893e),),



                                style: ElevatedButton.styleFrom(
                                    elevation: 0, primary: Colors.transparent)),



                          ),

                        ],),
                      ))),



              drawer: Drawer(
                elevation: 14,

                backgroundColor: Colors.black,

                child: Container(

      decoration: BoxDecoration(
      border: Border(right: BorderSide(width: 3.0, color: Color(0xfff6893e))),
      ),






      child: ListView(

                  padding: EdgeInsets.zero,
                  children: [
                     DrawerHeader(
                      decoration: BoxDecoration(
                        border: Border.symmetric(),
                        color: Colors.black,
                      ),

                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xfff6893e),
                              width: 2),
                          borderRadius: const BorderRadius.all(Radius
                              .circular(15)),),


                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [


                            const Icon(
                              FontAwesomeIcons.userAstronaut, size: 30,
                              color: Color(0xfff6893e),),

                             SizedBox(width: 10),


                             Text(FirebaseAuth.instance.currentUser!.displayName.toString(), style: TextStyle(
                              color: Color(0xfff6893e),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,),),
                        ],
                    ))),

                    SizedBox(height: 50,),


                    ElevatedButton.icon(
                        onPressed: () {


                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPassword()),
                                (Route<dynamic> route) => false,);



                        },

                        icon: const Icon(
                          FontAwesomeIcons.key, size: 40,
                          color: Color(0xfff6893e),),

                        label: const Text('Change password', style: TextStyle(
                          color: Color(0xfff6893e),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,),),

                        style: ElevatedButton.styleFrom(
                            elevation: 0, primary: Colors.transparent)),

                    SizedBox(height: 450,),


                    ElevatedButton.icon(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                                (Route<dynamic> route) => false,);
                        },

                        icon: const Icon(
                          FontAwesomeIcons.rightFromBracket, size: 40,
                          color: Color(0xfff6893e),),

                        label: const Text('Sign out', style: TextStyle(
                          color: Color(0xfff6893e),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,),),

                        style: ElevatedButton.styleFrom(
                            elevation: 0, primary: Colors.transparent)),





                  ],
                ),
              )),


              body: Align(
                alignment: Alignment.topCenter,


                child: _isLoading ?
                Loading() :


                ClickableListWheelScrollView(

                  scrollController: _scrollController,


                  itemHeight: 200,
                  itemCount: number,

                  onItemTapCallback: (index) {





                    FirebaseFirestore.instance.collection(
                        "Groups").get().then((querySnapshot) {
                          group = querySnapshot.docs[index].id.toString();

                        });


                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Chat(GroupName: group)));
                    },





                  child: ListWheelScrollView.useDelegate(



                    renderChildrenOutsideViewport: true,

                    overAndUnderCenterOpacity: 0.7,


                    clipBehavior: Clip.none,
                    controller: _scrollController,
                    itemExtent: 200 - (double.parse(number.toString()) * 17),


                    physics: const FixedExtentScrollPhysics(),

                    perspective: 0.001,
                    onSelectedItemChanged: (index) {

                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return FutureBuilder(future: LoadingScreen(),


                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {


                              return Container(


                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xfff6893e), width: 2),

                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(15))),

                                child: Loading(),


                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error', style: TextStyle(
                                    color: Colors.deepOrangeAccent));
                              } else if (snapshot.hasData) {

                                return _child(index);

                              } else {
                                return const Text('Empty data',
                                    style: TextStyle(
                                        color: Colors.deepOrangeAccent));
                              }
                            } else {
                              return Text('State: ${snapshot.connectionState}',
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent));
                            }

//https://www.woolha.com/tutorials/flutter-using-futurebuilder-widget-examples

                          },);
                      },
                      childCount: number,
                    ),
                  ),
                ),
              )),

        ),

      );
    }


    Future<String> LoadingScreen() async {
      await Future.delayed(Duration(seconds: 2), () {
        return Loading();
      });
      return "done";
    }




    Widget _child(int index) {

      return Center(

        child: Container(
            height: 200,
            width: 360,


            decoration: BoxDecoration(
                border: Border.all(color: Color(0xfff6893e), width: 2),

                borderRadius: const BorderRadius.all(
                    const Radius.circular(15))),


            child:

            Center(


              child:


              StreamBuilder<QuerySnapshot>(stream: groups,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    final data = snapshot.requireData;

                    final text = data.docs[index].id;







                    if (!snapshot.hasData) {
                      Text('Loading...');
                    }

                    if (snapshot.hasError) {
                      return const Text('Something went wrong.',
                          style: TextStyle(color: Colors.deepOrangeAccent));
                    }

                    else {
                      return Text(text,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xfff6893e), fontSize: 21.0, fontStyle: FontStyle.normal));
                    }

                  }),)),

      );
    }


  }









