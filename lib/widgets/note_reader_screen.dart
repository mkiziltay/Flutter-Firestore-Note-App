import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;

  NoteReaderScreen(this.doc,{Key? key }) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id =int.parse(widget.doc['color_id']) ;
    return Scaffold(
      backgroundColor: AppStyle.cardColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[color_id],
        elevation: 0.0,),
        body: Padding( padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['note_title'], style: AppStyle.mainTitle),
            SizedBox(height: 4.0),
            Text(widget.doc['creation_date'], style: AppStyle.dateTitle),
            SizedBox(height: 28.0),
            Text(widget.doc['note_content'], style: AppStyle.mainTitle, overflow: TextOverflow.ellipsis),
          ],
              ),
        ),
    );
  }
}
