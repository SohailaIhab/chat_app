import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ChatPage extends StatefulWidget {
   ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  CollectionReference Message=FirebaseFirestore.instance.collection("Messages");
   TextEditingController txtControllesr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<DocumentSnapshot>(
      future:Message.doc('TrRXiqTMN7jvphTO5x98').get() ,
      builder: (context,snapshot){
      return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(4,99,91,1),
        title: const Text("Chat"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
         Expanded(child: ListView.builder(itemBuilder: (context,index){
            return ChatBubble();}),), 
       Padding(padding:const EdgeInsets.all(16),
         child: TextField(
          controller: txtControllesr,
           onSubmitted: (value) {
             Message.add({'Text':value});
             txtControllesr.clear();
          },
          decoration: InputDecoration(
            hintText:"Send Message" ,
            suffixIcon: IconButton(icon:Icon(Icons.send, color: Color.fromRGBO(4,99,91,1)), 
            onPressed: () { Message.add({'Text':txtControllesr.text.toString() });
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
    });
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
  });

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
        child: Text("I am a new user",style:GoogleFonts.ubuntu(
               textStyle: const TextStyle(color: Colors.white,
               fontSize: 20),),),
       ),
    );
  }
}