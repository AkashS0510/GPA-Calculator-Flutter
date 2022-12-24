import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: "GPA Calculator",
    home: cgpa(),
    theme: ThemeData(
      // brightness: Brightness.dark
    ),
  ));
}

class cgpa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _cgpaState();
  }
}
List<String> ch = List.filled(8,'O');

class _cgpaState extends State<cgpa> {
  String _display="Created by Akash";

  var gpakey = GlobalKey<FormState>();

  List<TextEditingController> cre = [
    for (int i = 0; i < 8; i++) TextEditingController()
  ];

// var aval = AutovalidateMode.disabled;
  Widget build(BuildContext context) {
    // TODO: implement build
    // TextEditingController gra = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GPA Calculator",
          style: TextStyle(fontSize: 25.0),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Form(
        // autovalidateMode: aval,
        key: gpakey,
        child: ListView(
          children: [
            my_image(),
            heading(),
            for (int i = 0; i < 8; i++) field(i),
            buttons(),
            result()
          ],
        ),
      ),
    );
  }

  Widget credits() {
    return Expanded(
        child: Text(
          "Credits",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
        ));
  }

  Widget Grade() {
    return Expanded(
        child: Text("Grade",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700))
    );
  }

  Widget result() {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          _display,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w700),
        ));
  }

  Widget heading() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: [credits(), Grade()],
      ),
    );
  }

  Widget calci() {
    return Expanded(child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      onPressed: () {
        setState(() {
          if(gpakey.currentState!.validate()){
            this._display = _calculate();
            debugPrint(_display);
          }});
      },
      child: Text(
        "Calculate",
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    ));
  }

  String _calculate() {
    var dict=new Map();
    dict['O']=10;
    dict['A+']=9;
    dict['A']=8;
    dict['B+']=7;
    dict['B']=6;
    dict['P']=5;
    for(int i=0;i<8;i++){
      debugPrint(ch[i]);
    }
    double denom=0;
    for(int i=0;i<8;i++)denom+=double.parse(cre[i].text);
    double num=0;
    for(int i=0;i<8;i++){
      num+=double.parse(cre[i].text)* dict[ch[i]];
    }
    double c1 = double.parse(cre[0].text);
    debugPrint("$denom");
    double c2 = double.parse(cre[1].text);
    debugPrint("$num");
    double ans = num/denom;
    debugPrint("$ans");
    return "Your GPA is  \n $ans";
  }

  Widget reset() {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
        onPressed: () {
          setState(() {
            this._display="Created by Akash";
            for(int i=0;i<8;i++){
              _selected[i]=null;
            }
            // _selected=null;
            // aval=AutovalidateMode.disabled;
          });
          gpakey.currentState!.reset();
          for(int i=0;i<8;i++) cre[i].clear();
        },
        child: Text(
          "Reset",
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget buttons(){
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          calci(),
          Container(
            width: 25.0,
          ),
          reset()
        ],
      ),
    );
  }

  Widget field(int i) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            text(i),
            Container(
              width: 20.0,
            ),
            grade_select(i)
          ],
        ));
  }

  Widget text(int i) {

    return Expanded(
        child: TextFormField(

            keyboardType: TextInputType.number,
            controller: cre[i],
            validator: (String? value){
              if(value!.isEmpty){
                return "Please enter the Credits";
              }
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.menu_book),
                labelText: "Subject ${i + 1}",
                labelStyle: TextStyle(fontSize: 18.0),
                hintText: "Enter Credits",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0, color: Colors.black87)),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0, color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 2.0, color: Colors.red)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                    BorderSide(width: 2.0, color: Colors.black87)))));
  }
}

class grade_select extends StatefulWidget {
  @override
  int i;
  grade_select(this.i);
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return grade_selectState(i);
  }
}
List<String?> _selected=[null,null,null,null,null,null,null,null];

class grade_selectState extends State<grade_select> {
  var grades = ['O', 'A+', 'A','B+','B',"P"];
  int i;
  grade_selectState(this.i);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child:
        DropdownButtonFormField(
            decoration:
            InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),borderSide: BorderSide(width: 15.0,style: BorderStyle.solid),)),
            dropdownColor: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(15.0),
            isExpanded: true,
            iconEnabledColor: Colors.black87,
            hint: const Text("Select Grade"),
            items:
            grades.map((String value) {
              return DropdownMenuItem(child: Text(value), value: value);
            }).toList(),
            value: _selected[i],
            validator: (value){
              if(_selected[i]==null)return "Please Choose a Grade";
            },
            onChanged: (String? newvalue) {
              setState(() {
                debugPrint(newvalue);
                _selected[i] = newvalue;
                // ch[i]=newvalue!;
                ch[i]=newvalue!;
                // debugPrint(ch[i]);
              });
            }));
  }
}

Widget my_image() {
  AssetImage image = AssetImage("images/snu.jpg");
  Image img = Image(image: image);
  return Container(
    margin: EdgeInsets.all(30.0),
    child: img,
  );
  ;
}
