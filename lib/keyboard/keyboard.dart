import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);




  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final myController = TextEditingController();
  final emotionDict = {
    'happy' : ['😀', '😁', '😂', '🤣'],
    'sad': ['😕', '🙁', '😣', '😫'],
    'fear': ['😧', '😦', '😰', '😨'],
    'anger': ['😠', '😤', '😡', '🤬'],
    'disgust': ['😫', '😵', '🤢', '🤮'],
    'surprise': ['😯', '😲', '😵', '🤯']
  };
  var detectedEmotion = 'neutral';

  void _printLatestValue() {
    if (myController.text.isNotEmpty){
      if (myController.text.length > 4){
        setState(() {
          detectedEmotion = "sad";
        });
      }
      if (myController.text.length > 6){
        setState(() {
          detectedEmotion = "happy";
        });
      }
    }
    if (kDebugMode) {
      print('The emotion is : $detectedEmotion');
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children : [
          const Padding(padding:  EdgeInsets.only(top: 140.0)),
          Text('Emotion Detection Keyboard',
            style:  TextStyle(color: HexColor("#F2A03D"), fontSize: 25.0),),
          const Padding(padding: EdgeInsets.only(top: 50.0)),
           Row(
             children: [
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: TextField(
                     minLines: 1,
                     maxLines: 5,
                     decoration:  const InputDecoration(
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey, width: 2.0),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey, width: 2.0),
                       ),
                       hintText: 'Message',
                     ),
                     controller: myController,
                   ),
                 ),
               ),
               InkWell(
                 onTap: () {
                   setState(() {
                     myController.text = myController.text + emotionDict[detectedEmotion]![0];
                   });
                 },
                 child: const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: Text("😀", style: TextStyle(
                     fontSize: 20,
                   ),),
                 ),
               )
             ],
           )
        ]
    );
  }
}

