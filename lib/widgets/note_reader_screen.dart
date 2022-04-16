// ignore_for_file: non_constant_identifier_names, avoid_init_to_null

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;
  String? notetitle = null;
  String? notecontent = null;
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);

  @override
  State<NoteReaderScreen> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReaderScreen> {
  bool edittitle = false, editcontent = false;
  @override
  Widget build(BuildContext context) {
    int color_id = int.parse(widget.doc['color_id']);
    TextEditingController _titlecontroller = TextEditingController();
    TextEditingController _contentcontroller = TextEditingController();
    _titlecontroller.text = widget.doc['note_title'];
    _contentcontroller.text = widget.doc['note_content'];

    return Scaffold(
      backgroundColor: AppStyle.cardColors[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColors[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    edittitle = !edittitle;
                    setState(() {});
                  },
                  child: edittitle == true
                      ? TextField(
                          controller: _titlecontroller,
                          onSubmitted: (newValue) {
                            edittitle = !edittitle;
                            widget.notetitle = _titlecontroller.text;
                            _updateNotesField('note_title', newValue);
                            setState(() {});
                          },
                        )
                      : Text(
                          widget.notetitle == null
                              ? _titlecontroller.text
                              : widget.notetitle.toString(),
                          style: AppStyle.mainTitle)),
              const SizedBox(height: 4.0),
              Text(widget.doc['creation_date'], style: AppStyle.dateTitle),
              const SizedBox(height: 28.0),
              GestureDetector(
                  onTap: () {
                    editcontent = !editcontent;
                    print(
                        'editcontent = $editcontent and id = ${widget.doc.id}');
                    setState(() {});
                  },
                  child: editcontent == true
                      ? TextField(
                          controller: _contentcontroller,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (newValue) {
                            editcontent = !editcontent;
                            widget.notecontent = _contentcontroller.text;
                            _updateNotesField('note_content', newValue);
                            setState(() {});
                          },
                        )
                      : Text(
                          widget.notecontent == null
                              ? _contentcontroller.text
                              : widget.notecontent.toString(),
                          style: AppStyle.mainTitle,
                          overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          _deleteNotesField(widget.doc.id);
        },
        child: const Icon(Icons.delete),
      ),
    );
  }

  _updateNotesField(String field, String value) {
    FirebaseFirestore.instance
        .collection('Notes')
        .doc(widget.doc.id)
        .update({field: value}).then((result) {
      print("changes applied succesfully...");
    }).catchError((onError) {
      print("onError");
    });
  }

  _deleteNotesField(String id) async {
    FirebaseFirestore.instance
        .collection('Notes')
        .doc(id)
        .delete()
        .then((value) {
      print('${id} succesfully deleted...');
      Navigator.pop(context);
    }).catchError((error) => print('Failed to delete the note due to $error'));
  }
}
