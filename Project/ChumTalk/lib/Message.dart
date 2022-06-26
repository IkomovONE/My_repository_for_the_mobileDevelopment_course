import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chumtalk/Groups.dart';





class MessageBuilder extends StatelessWidget {

  final String GroupId;

  const MessageBuilder({

    required this.GroupId,



  });




  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
        stream: Groups.getAllMessages(GroupId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return ListView(


        physics: BouncingScrollPhysics(),
        reverse: true,




        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return MessageWidget(
            data['message'],
            data['userName']== FirebaseAuth.instance.currentUser!.displayName.toString(),
            data['time'].toString(),
            data['userName'],
          );
        }).toList(),
      );







    }


//https://firebase.flutter.dev/docs/firestore/usage/






    ); }




Widget MessageWidget(String message, bool isMe, String time, String user){




  return Row(

    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,

    children: <Widget>[

      if (!isMe)

        Container(
            padding: EdgeInsets.all(8),


      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff6893e), width: 2),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15))),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            Row(

              mainAxisAlignment: MainAxisAlignment.start,


              children: [

                Text(user, style: TextStyle(color: Color(0xfff6893e).withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold,),),



              ],


            ),


        Container(
          constraints: BoxConstraints(maxWidth: 250),

          child:
            Text(message, style: TextStyle(color: Color(0xfff6893e), fontSize: 15, fontWeight: FontWeight.bold,),)),


            Row(

              mainAxisAlignment: MainAxisAlignment.end,


              children: [



                Text(time, style: TextStyle(color: Color(0xfff6893e).withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold,),),

              ],


            ),

          ],

        ),

      )),

      if (isMe)
      Container(
      padding: EdgeInsets.all(8),


      child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
      border: Border.all(color: Color(0xfff6893e), width: 2),
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15))),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

      children: <Widget>[

      Row(

        mainAxisAlignment: MainAxisAlignment.end,


      children: [



      Text(user, style: TextStyle(color: Color(0xfff6893e).withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold,),),



  ],


  ),





Container(
    constraints: BoxConstraints(maxWidth: 250),

  child:
  Text(message,  style: TextStyle(color: Color(0xfff6893e), fontSize: 15, fontWeight: FontWeight.bold,),)),


  Row(
    mainAxisAlignment: MainAxisAlignment.start,


  children: [



  Text(time, style: TextStyle(color: Color(0xfff6893e).withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold,),),


  ],


  ),

  ],

  ),

  )),




    ],

  );

}

}
