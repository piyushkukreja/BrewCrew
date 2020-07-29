import "package:flutter/material.dart";

const textInputDecoration = InputDecoration(// basic syntax for input field decoration
                fillColor: Colors.white,
                filled: true,//necessary to set if fillColor is set
                //enabled border only works when its not in focus
                enabledBorder: OutlineInputBorder(//border for the input field
                  borderSide: BorderSide(//widget for borderside
                    color: Colors.white,
                    width: 2.0,
                  ),
                
                ),
                focusedBorder: OutlineInputBorder(//border for the input field
                  borderSide: BorderSide(//widget for borderside
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
              );