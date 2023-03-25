import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'message_model.dart';
class ChatPage extends StatefulWidget {
   ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  CollectionReference message=FirebaseFirestore.instance.collection("Messages");
   TextEditingController txtControllesr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream:message.orderBy('createdAt').snapshots() ,
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<Message>messageList=[];
          for(int i=0;i<snapshot.data!.docs.length;i++){
            messageList.add(Message.fromJson(snapshot.data!.docs[i] ));
          }
      return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(4,99,91,1),
        title: const Text("Chat"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
         Expanded(
          child: ListView.builder(
            itemCount: messageList.length,
          itemBuilder: (context,index){
            return ChatBubble(txt: messageList[index],);
            }),
            ), 
       Padding(padding:const EdgeInsets.all(16),
         child: TextField(
          controller: txtControllesr,
           onSubmitted: (value) {
             message.add({
              'Text':value,
             'createdAt':DateTime.now()});
             txtControllesr.clear();
          },
          decoration: InputDecoration(
            hintText:"Send Message" ,
            suffixIcon: IconButton(icon:Icon(Icons.send, color: Color.fromRGBO(4,99,91,1)), 
            onPressed: () { 
            message.add({'Text':txtControllesr.text.toString(),'createdAt':DateTime.now()});
             txtControllesr.clear(); },),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:const BorderSide(color: Color.fromRGBO(4,99,91,1))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:const  BorderSide(color: Color.fromRGBO(4,164,156,3))),
                ),),
       ) 
          ],
      ),
    );
    }else{return Text("Loading...");}
    },);
  }
}

class ChatBubble extends StatelessWidget {
 const  ChatBubble({ required this.txt    });
final Message txt;
  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft,
      child: Container(
       
       
        padding:const EdgeInsets.only(left:16,top: 16,bottom: 16,right: 16),
        margin:const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(30) ,
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30)),
          color:Color.fromRGBO(4,164,156,3)        ),
        child: Text(txt.txt,style:GoogleFonts.ubuntu(
               textStyle: const TextStyle(color: Colors.white,
               fontSize: 20),),),
       ),
    );
  }
}