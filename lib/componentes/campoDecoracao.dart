import 'package:flutter/material.dart';

InputDecoration getInputdecoration(String label) {
  return InputDecoration(
    hintText: label,
    fillColor: Colors.white30,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(64)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(64),
        borderSide: BorderSide(color: Colors.black, width: 1 )
      ),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(64),
      borderSide:  BorderSide(color: Colors.green, width: 4)
      ),
  );
}


