class Message{
 final String txt;

  Message(this.txt);
factory  Message.fromJson( data){
    return Message(data['Text']);
  }
}