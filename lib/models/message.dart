



class Messages {

  final String from;
  final String to;
  final DateTime timestamp;
  final String contents;
  String id;


  Messages({
    required this.from,
    required this.to,
    required this.timestamp,
    required this.contents,
    required this.id,
  });


//toJson
  Map<String, dynamic> toJson() =>
      {
        'from': from,
        'to': to,
        'timestamp': timestamp,
        'contents': contents,
        'id': id,
      };

//fromJson
  factory Messages.fromJson(Map<String, dynamic> json) {
    final messages = Messages(
      from: json['from'],
      to: json['to'],
      timestamp: json['timestamp'],
      contents: json['contents'],
      id: '',

    );
    messages.id = json['id'];
    return messages;
  }

}




