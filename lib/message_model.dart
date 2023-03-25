class Message{
 final String txt;
final String id;
  Message(this.txt,this.id);
factory  Message.fromJson( data){
    return Message(data['Text'],data['id']);
  }
}