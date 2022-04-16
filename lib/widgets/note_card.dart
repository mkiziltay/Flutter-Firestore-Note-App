import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/style/app_style.dart';

Widget noteCard(Function()? onTap,QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: AppStyle.cardColors[int.parse(doc['color_id'])],
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['note_title'], style: AppStyle.mainTitle),
          const SizedBox(height: 4.0),
          Text(doc['creation_date'], style: AppStyle.dateTitle),
          const SizedBox(height: 4.0),
          Text(doc['note_content'].toString().replaceAll("\n", "..."), style: AppStyle.mainTitle,
          overflow: TextOverflow.ellipsis),
        ],
      ),
    ),
  );
}
