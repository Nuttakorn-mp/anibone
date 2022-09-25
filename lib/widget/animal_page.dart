// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//---------------------------------- this 3d page --------------------------------------//
var pic = 0;
var index = 0;
var drag = [0.0, 0.0];
var dragIndex = 0;
// var imgName;
double radiant = 0.0;
var tag = {
  "Arapaima2": {
    "degree": 30,
    "have": 3.0
  }, //22.5 , degree = 360/img.length // have => in 90องศา มีกี่รูป
  "BarkingDeer2": {"degree": 30, "have": 3.0}, //27.69,
  //"BengalTiger": {"degree": 30, "have":3.0},//22.5,
  "tiger": {"degree": 30, "have": 3.0}, //22.5,
};
String name = '';
var dragToPic = 0;
double calDrag = 0.0;
var yDrag = [0.0, 0.0];
var yIndex = 0;
var stackRang = 0.0;
double limitStackRangB = 0.0;
double limitStackRangA = 0.0;
double x = 200;
double y = 200;
double degree = 0;
double stackDegree = 0;
double userMoveConditionY = 0.0;
double errorMoveX = 0.0;
double errorMoveY = 0.0;
double fixed = 0.0;
double userDrag = 0.0;
double stackUp = 0.0;

double part = 112.2077921;
double setHeight=300.0;
double setWidth=411.42857142857144;
double calPad=100.0;

double calPart=1.0;
double pushCenter=0.0;
double arrowPad=0.0;

double textSize=25.0;
bool textSet =false;
double textScale=1.0;
double textPaintSize=12.0;

bool showDetail = true;
String hint = "กดลูกศรเพื่อดูรายละเอียดในมุมต่างๆ";
String hint2 = '''- กดลูกศรเพื่อดูรายละเอียดในมุมต่างๆ 
- ปัดนิ้วจากขวาไปซ้ายเพื่ออ่านคำอธิบาย
- ปัดนิ้วจากซ้ายไปขวาเพื่อกลับมาหน้าแรก''';

// ignore: prefer_typing_uninitialized_variables
var a;// use to call rotate 3d model

class AnimalPage extends StatefulWidget {
  //initial constructor
  final String animalName;
  // final String id;
  final String model;
  // final http.Response req; //ถ้ารับจาก api มาต้องเปิดใช้งานบรรทัดนี้
  final List req; //เอาข้อมูลยัดเอง
  const AnimalPage(
      {Key? key,
      required this.req,
      required this.model,
      required this.animalName,
      // required this.id
      }) // use "widget.animalName" to call data from pass
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  // ignore: prefer_typing_uninitialized_variables
  static var imgInfos;
  static var des = imgInfos[0]['animal']['0']['description'] = '';
  static var imgNow = imgInfos[0]['animal']['0']['completeImagePath'][0];
  static var keyImg = [];
  static var tagAll = [];
  static var pad = 0.0;
  static double startX = 0.0;
  static double startY = 0.0;
  static double lineToX = 0.0;
  static double lineToY = 0.0;
  static double textX = 0.0;
  static double textY = 0.0;
  static String title = ' ';
  static double positionX = 0.0;
  static double positionY = 0.0;
  static double width = 0.0;
  // ignore: unused_field
  static double high = 0.0;
  // bool _visible = false;
  bool _loading = true;
  static bool _dialogShowHeight = true;
  static bool _dialogShowWidth = true;
  static double padHint=0.0;

  // ignore: prefer_typing_uninitialized_variables
  // var a;// use to call rotate 3d model
  var showTagNow = 0.0;
  var showTagNext = 0.0;
  double degree = 0;

  final ScrollController _controller = ScrollController();

  void startdrag(details) {
    print("start : ");
    drag[dragIndex] = details.globalPosition.dx;
    dragIndex = 1;
    // print(details.globalPosition.dx);
    print("");
  }

  void updatedrag(details) {
    drag[dragIndex] = details.globalPosition.dx; //1.7432

    yDrag[yIndex] = details.globalPosition.dy;
    yIndex = 1;

    print("updateDrag-----------running-------------");
    // print("X Axis start drag : "+ drag[0].toString()+" && "+"end drag : "+drag[1].toString());
    // print("Y Axis start drag : "+ yDrag[0].toString()+" && "+"end drag : "+yDrag[1].toString());
    print(details.delta);
    print("");

    setState(() {
      imgNow = null;
      dragToPic = 0;
    });
    // print("1111");
  }

  void updatetag(details) {
    //MediaQuery.of(context).size.width
    print("update Tag");
    userDrag = drag[1] - drag[0]; //===> rang
    if (userDrag > 0) {
      userDrag = userDrag - 14;
    } else {
      userDrag = userDrag + 14;
    }
    errorMoveY = yDrag[1] -
        yDrag[
            0]; //ถ้าติดลบ เวลา+ก็จะได้เลื่อนtagมาหา  //ถ้าติดบวก เวลา+ก็จะได้เลื่อนtagมาหา
    // errorYCalToX = errorYCalToX+(errorMoveY*2).abs();
    stackRang = stackRang + userDrag; //+ errorYCalToX
    stackUp = stackUp +
        userDrag.abs(); //ระยะลากสะสมก่อนถึงจุดเปลี่ยนภาพ คำนวณแค่ระยะ ไม่สนมุม
    print("drag[0] : ${drag[0].toStringAsFixed(3)}");
    print("drag[1] : ${drag[1].toStringAsFixed(3)}");
    print(userDrag);

    limitStackRangB = 2 * width;
    // limitStackRangB = 864;
    limitStackRangA = 2 * width * (-1);

    if (stackRang > limitStackRangB) {
      //ถ้าเกิน แปลว่าหมุนเกิน 360 องศาแล้ว
      print("> limitStackRangB");
      stackRang = stackRang - limitStackRangB;
    } else if (stackRang <= limitStackRangA) {
      //ถ้าน้อยกว่า แปลว่าหมุนเกิน -360 องศาแล้ว
      print("< limitStackRangA");
      stackRang = stackRang + limitStackRangA;
    }

    // else{//notice bug
    //   print("");
    //   print("");
    //   print("stackrang : "+stackRang.toString());
    //   print("limitStackrangA : "+limitStackRangA.toString());
    //   print("limitStackrangB : "+limitStackRangB.toString());
    //   print("");
    //   print("");
    // }//ค่า stackRang ที่ได้จะมีค่าภายในตั้งแต่ 0- (2*width) ==> 0-822

    // var tempY = (math.asin(errorMoveY/stackRang) );//*(180/math.pi) ==> rad to degree
    // print("tempY ::: "+tempY.toString());

    dragIndex = 0;
    yIndex = 0;

    //------------------------------------------------------------------------
    //ปรับระยะให้ไม่เกิน360
    var limit = imgInfos[0]['animal']['0']['completeImagePath'].length; //จน รูป
    var rang = userDrag.abs(); //ระยะทางที่ลาก

    if (rang >= 360) {
      rang = rang % 360;
    } else if (rang <= -360) {
      rang = rang + 360;
    }

    //------------------------------------------------------------------------
    //function นี้เป็นการหามุมจากการลากนิ้วเท่านั้น ว่าการลากนิ้วครั้งนี้ คิดเป็นมุมเท่าไหร่ คิดทีละ 30 (คิดจากระยะทางที่ลาก)
    for (var i = 0; i < limit; i++) {
      //0 - 11
      print("i ::: $i");
      var limitA = (i - 1) * part + (part / 2.0);
      var limitB = (i * part) + (part / 2.0);
      if (i == 0 || i == 1) {
        var tempLimitA = 0 * (part) + (i * (part / 2.0));
        var tempLimitB = (i * part) + (part / 2.0);
        print("Rang ---- Case 1 -----");
        print("$tempLimitA < $rang <= $tempLimitB ");
        if (rang > tempLimitA && rang <= tempLimitB) {
          radiant = (i / (tag[widget.model]!['have'])!.toDouble()) * 90.0;
          break;
        }
      } else if (rang > limitA && rang <= limitB) {
        print("Rang ---- Case 2 -----");
        print("i ::: $i pass !!!");
        print("$limitA < $rang <= $limitB ");
        radiant = (i / (tag[widget.model]!['have'])!.toDouble()) * 90.0;
        break;
      } else if ((limitA) > 360) {
        print("Rang ---- Case 3 -----");
        print("limit > 360 ");
        radiant = (i / (tag[widget.model]!['have'])!.toDouble()) * 90.0;
        break;
      }
    }
    if (drag[1] < drag[0]) {
      radiant = radiant * (-1);
    } //ถ้าลากไปทางซ้าย มุมที่ได้จะเป็นลบ
    print("radiant is ::: $radiant");
    print(" ");
    print(" ");
    //output ===> radiant
    //------------------------------------------------------------------------

    //------------------------------------------------------------------------
    // คำนวณรูปที่ลากไป
    setState(() {
      degree = (degree + radiant);
    });
    // degree = (degree + radiant);
    if (degree.abs() >= 360) {
      setState(() {
        degree = degree.abs() - 360;
      });
    }
    // }
    print('X start ${drag[0]} end : ${drag[1]}');
    print("degree : $degree");
    // print(degree);
    calDrag = (degree / tag[widget.model]!['degree']!);
    if ((calDrag + 0.5) - 1 < -1) {
      print("case1");
      setState(() {
        dragToPic = ((calDrag + 0.5) -
                1 +
                imgInfos[0]['animal']['0']['completeImagePath'].length)
            .toInt();
      });
    } else if ((calDrag + 0.5) >
        imgInfos[0]['animal']['0']['completeImagePath'].length) {
      print("case2");
      setState(() {
        // dragToPic = (calDrag + 0.5).round() -
        //     (imgInfos[0]['animal']['0']['completeImagePath'].length);

        int aaa = (calDrag + 0.5).round();
        int bbb = (imgInfos[0]['animal']['0']['completeImagePath'].length);
        dragToPic = aaa - bbb;
      });
    } else {
      print("case3");
      setState(() {
        // dragToPic = (calDrag+0.5).round();
        dragToPic = (calDrag + 0.5).toInt();
        // stackRang = 0.0;
        // dragToPic = calDrag.toInt();
      });
    }
    if (calDrag < 0) {
      dragToPic = dragToPic + 1;
    }
    print("drag2Pic is : $dragToPic");
    // print(calDrag.toInt());

    //output ==> dragToPic
    //-------------------------------------------------------------------------------------

    //-------------หลังstackUpจนถึงจุดเปลี่ยนรูปแล้ว ต้องอัพเดท ดีกรีใหม่ด้วย==> แต่ไม่ได้ใช้แล้ว---------------
    //part = ( width/2 (ครึ่งจอ) )/3 ==>68
    if (dragToPic == 0) {
      if (radiant == 0.0) {
        if (stackUp < (part / 2)) {
          //ลากน้อยกว่า 30 องศา และยังไม่เปลี่ยนรูป
          errorMoveX =
              (stackRang.abs()) % (part / 2); //ระยะทางที่ลากจากองศา ปจบ
          if (stackRang < 0) {
            errorMoveX = errorMoveX * (-1);
          } //errXติดลบ เพื่อที่เอาไปบวกให้Tagที่กำหนดไว้ ขยับไปทางซ้าย
          // print("radiant = 0.0 , errorX = "+errorMoveX.toStringAsFixed(3));
        } else if (stackUp >= (part / 2)) {
          //ลากสั้นๆ แล้วสะสมมุมเกินจุดเปลี่ยนภาพ
          if (stackRang >= 0) {
            //ลากสั้นๆหลายครั้งไปทางขวา
            dragToPic = 1;
            stackUp = stackUp - (part / 2);
            setState(() {
              degree = degree + 30;
            });
            errorMoveX = -((part / 2) -
                stackUp); //ระยะทางที่จุดลาก ห่างจากTag นับจากรูป 1
          } else {
            //ลากสั้นๆหลายครั้งไปทางซ้าย
            dragToPic = 11;
            stackUp = stackUp - (part / 2);
            setState(() {
              degree = degree - 30;
            });
            errorMoveX =
                (part / 2) - stackUp; //ระยะทางที่จุดลาก ห่างจากTag นับจากรูป 11
          }
        }
      } else {
        //radiant !=0.0
        var limitA = (11 * part) + (part / 2);
        var limitB = part / 2;
        //ลากมาจากซ้ายไปขวา
        if (stackRang > limitA && stackRang <= limitStackRangB) {
          //ฝั่งซ้ายก่อนจะถึง จุดที่Tag
          stackUp = (stackRang.abs()) % (part / 2);
          errorMoveX = (part / 2) - stackUp;
          errorMoveX = (-1) * errorMoveX;
        } else if (stackRang > 0 && stackRang <= limitB) {
          //ฝั่งขวาของจุดที่Tag
          stackUp = (stackRang.abs()) % (part / 2);
          errorMoveX = stackUp;
        }

        //ลากจากขวามาซ้าย
        else if (stackRang < 0 && stackRang >= -limitB) {
          //ฝั่งซ้ายของ จุดที่Tag
          stackUp = (stackRang.abs()) % (part / 2);
          errorMoveX = stackUp;
          errorMoveX = (-1) * errorMoveX;
        } else if (stackRang < -limitA && stackRang >= limitStackRangA) {
          //ฝั่งขวาของ จุดที่Tag
          stackUp = (stackRang.abs()) % (part / 2);
          errorMoveX = (part / 2) - stackUp;
        }
      }
    } else if (dragToPic == 11) {
      var limitA = (10 * part) + (part / 2.0);
      var limitB = (11 * part) + (part / 2.0);
      if (radiant == 0.0 && stackRang > limitA) {
        //ลากมุมน้อยกว่า30 และอยู่ในระยะรูป11
        //ลากจากซ้ายไปขวา
        if (stackUp < (part / 2)) {
          //ฝั่งซ้ายก่อนจะถึง จุดที่Tag
          errorMoveX = (part / 2) -
              (stackRang.abs() % (part / 2)); //ระยะห่างที่ลากจากองศา ปจบ
          errorMoveX = (-1) *
              errorMoveX; //errXติดลบ เพื่อที่เอาไปบวกให้Tagที่กำหนดไว้ ขยับไปทางซ้าย
          //if(stackRang<0){errorMoveX = errorMoveX*(-1);}
        } else if (stackUp >= (part / 2) && stackUp < part) {
          //ฝั่งซ้ายstackupจนไปฝั่งขวาจนถึงก่อนเปลี่ยนรูป
          stackUp = stackUp - (part / 2);
          errorMoveX = (stackRang.abs()) %
              (part / 2); //ระยะทางที่จุดลาก ห่างจากTag นับจากรูป 11
        } else if (stackUp >= part) {
          //ฝั่งขวาที่stackupแล้วถึงจุดเปลี่ยนรูป
          stackUp = stackUp - part;
          dragToPic = 0;
          setState(() {
            degree = 0;
          });
          errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
          errorMoveX = (-1) * errorMoveX;
        }
      } else if (radiant == 0.0 && stackRang >= -(part / 2)) {
        //ลากมุมน้อยกว่า30 และอยู่ในระยะรูป11 ไม่เกินจุดเปลี่ยนรูป
        //ลากจากขวาไปซ้าย
        if (stackUp < (part / 2) && stackRang < 0) {
          //ฝั่งขวาก่อนจะถึง จุดที่Tag
          errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
        } else if (stackUp >= (part / 2) && stackUp < part && stackRang < 0) {
          //ฝั่งขวาstackupจนไปฝั่งซ้ายจนถึงก่อนเปลี่ยนรูป
          errorMoveX = (stackRang.abs()) % (part / 2);
          errorMoveX = (-1) * errorMoveX;
        } else if (stackUp >= part && stackRang < 0) {
          //ฝั่งซ้ายที่stackupแล้วถึงจุดเปลี่ยนรูป
          stackUp = stackUp - part;
          dragToPic = dragToPic - 1;
          setState(() {
            degree = degree - 30;
          });
          errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
        }
      } else {
        //ลากมุมมาหยุดที่รูปนี้ ลากมุมเกิน30 องศา
        //ลากมาจากซ้ายไปขวา
        if (stackRang > limitA && stackRang <= (limitA + (part / 2))) {
          //ฝั่งซ้ายก่อนจะถึง จุดที่Tag
          stackUp = stackRang % (part / 2);
          errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
          errorMoveX = (-1) * errorMoveX;
        } else if (stackRang > (limitA + (part / 2)) && stackRang <= limitB) {
          //ฝั่งขวาของจุดที่Tag
          stackUp = stackRang.abs() % (part / 2);
          errorMoveX = (stackRang.abs()) % (part / 2);
        }
        //ลากมาจากขวาไปซ้าย
        else if (stackRang < -(part) && stackRang >= -(part + (part / 2))) {
          //ฝั่งซ้ายก่อนจะถึง จุดที่Tag
          stackUp = stackRang.abs() % (part / 2);
          errorMoveX = (-1) * stackUp; //มีค่าเป็นลบเพื่อเลื่อนTagมาทางซ้าย
        } else if (stackRang < -(part / 2) && stackRang >= -part) {
          //ฝั่งขวาของจุดที่Tag
          stackUp = stackRang.abs() % (part / 2);
          errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
          // errorMoveX = (-1)*errorMoveX;
        }

        print("radiant : ${radiant.toStringAsFixed(3)}");
        print("");
      }
    } else {
      //รูปตั้งแต่1 - 10
      if (radiant == 0.0) {
        //คำนวณมุมละเอียด
        //มี dragToPic, degree , radiant
        var limitA = (dragToPic - 1) * part;
        if (dragToPic == 1) {
          limitA = part / 2;
        }
        var limitB = (dragToPic * part) + (part / 2);
        if (stackRang > 0) {
          //ลากจากซ้ายไปขวา
          if (stackRang > limitA && stackRang <= limitB) {
            //ลากสั้นๆ แต่ยังไม่เปลี่ยนรูป
            if (stackUp < (part / 2)) {
              //ฝั่งซ้ายก่อนจะถึง จุดที่Tag
              errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
              errorMoveX = (-1) * errorMoveX;
            } else if (stackUp >= (part / 2) && stackUp < part) {
              //ฝั่งซ้ายstackupจนไปฝั่งขวาจนถึงก่อนเปลี่ยนรูป
              errorMoveX = (stackRang.abs()) % (part / 2);
            }
          } else if (stackRang <= limitA) {
            //ลากสั้นๆไปทางซ้ายจนเปลี่ยนรูป
            stackUp = stackUp - (part / 2);
            dragToPic = dragToPic - 1;
            setState(() {
              degree = degree - 30;
            });
            errorMoveX = stackUp;
          } else if (stackRang > limitB) {
            //ลากสั้นๆไปทางขวาจนเปลี่ยนรูป
            stackUp = stackUp - part;
            dragToPic = dragToPic + 1;
            setState(() {
              degree = degree + 30;
            });
            errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
            errorMoveX = (-1) * errorMoveX;
          }
        } else {
          //stackRang<0 ==>ลากจากขวาไปซ้าย
          if (stackRang < -limitA && stackRang >= -limitB) {
            //ลากสั้นๆ แต่ยังไม่เปลี่ยนรูป
            if (stackUp < (part / 2)) {
              //ฝั่งขวาก่อนจะถึง จุดที่Tag
              errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
            } else if (stackUp >= (part / 2) && stackUp < part) {
              //ฝั่งขวาstackupจนไปฝั่งซ้ายจนถึงก่อนเปลี่ยนรูป
              errorMoveX = (stackRang.abs()) % (part / 2);
              errorMoveX = (-1) * errorMoveX;
            }
          } else if (stackRang >= -limitA) {
            //ฝั่งขวาที่stackup แล้วถึงจุดเปลี่ยนรูป
            stackUp = stackUp - part;
            dragToPic = dragToPic + 1;
            errorMoveX = (stackRang.abs() % (part / 2));
            errorMoveX = (-1) * errorMoveX;
          } else if (stackRang < -limitB) {
            //ฝั่งซ้ายที่stackupแล้วถึงจุดเปลี่ยนรูป
            stackUp = stackUp - part;
            dragToPic = dragToPic - 1;
            errorMoveX = (part / 2) - (stackRang.abs() % (part / 2));
          }
        }
      } //ต้องคำนวณแก้อยู่ ทำหลังคำนวณหยาบ ==>แต่ไม่ได้ใช้แล้ว
      else {
        //คำนวณหยาบ
        if (stackRang > 0) {
          //ลากไปทางขวา
          stackUp = stackRang % (part);

          if (stackRang >= (((dragToPic - 1) * part) + (part / 2.0)) &&
              stackRang < (dragToPic * part)) {
            //ฝั่งซ้ายของTag
            // errorMoveX = stackUp;
            errorMoveX = (part) - stackUp;
            errorMoveX = (-1) * errorMoveX;
          } else {
            // ==>ฝั่งขวาของTag
            errorMoveX = stackUp - 16;
            // errorMoveX = (part) - stackUp;
            // errorMoveX = (-1)*errorMoveX;
          }
        } else {
          //stackRang<0 ==> ลากไปทางซ้าย
          stackUp = stackRang.abs() % (part / 2);
          if (stackUp < (part / 2)) {
            //ฝั่งขวาของTag
            errorMoveX = (part / 2) - stackUp;
          } else {
            //stackUp>=(part/2) ==>ฝั่งซ้ายของTag
            errorMoveX = -stackUp;
          }
        }
      }
    }
    //-------------------------------------------------------------------------------------

    setState(() {
      imgNow = imgInfos[0]['animal']['0']['completeImagePath'][dragToPic];
    });

    print(imgNow); // ในรูปที่หมุนนี้เป็นรูปอะไร
    // print('contain ???');
    // print(keyImg.contains(imgNow).toString());
  }

  getImg() async {
    // getImg(){
    // print("animal_page Start!");
    // print(widget.animalName);
    // print(widget.id);
    // print(widget.model);
    //String api = 'http://192.168.1.103:3000/animal/bone/mobile/${widget.id}';   //http://192.168.1.106:3000

    // String api = 'http://192.168.1.103:4000/getAnimalName/mobile/${widget.id}';
    // print(api);
    // var req = await http.get(api);

    var req = widget.req;

    imgInfos = null;
    // imgInfos = json.decode(req.body); //ถ้ารับจาก api มาต้องเปิดใช้งานบรรทัดนี้
    imgInfos = req; //เอาข้อมูลยัดเอง
    // print("imgInfos : ");
    // print(imgInfos[0]['animal']);

    // if (keyImg != null) {
    //keyImg.length==0
    // print("keyimg != null -----------------");
    keyImg = [];
    for (var item in imgInfos[0].keys) {
      keyImg.add(item);
      // break;
    }
    // }
    // print("key is");
    // print(keyImg);

    imgNow = imgInfos[0]['animal']['0']['completeImagePath'][0];
    des = imgInfos[0]['animal']['0']['description'].toString();
    // print("imgnow is :$imgNow");
    return imgInfos;
    // print("des is :"+des.toString());

    // print("imgnow is"+imgNow.toString());

    // print(imgInfos);
    // print(keyImg.length);
  }

  delayLoad() {
    Timer(const Duration(seconds: 4), () {
      // print("print after every 4 seconds");
      setState(() {
        _loading = false;
      });
      // print("_loading : "+ _loading.toString());
    });
  }

  set(var widthInput, var highInput) {
    _AnimalPageState.width = widthInput;
    // _AnimalPageState.width = 455;//+35
    _AnimalPageState.high = highInput;
    // part = (411.42857142857144 / (2.toDouble())) /
    //     (tag[widget.model]!['have'])!.toDouble(); //ครึ่งจอ หาร3
    print("");
    _scollBack();
    if(MediaQuery.of(context).size.width> 411.42857142857144){
      print("device width > 411.42857142857144");
      // arrowPad = 50.0;
      //ไอแพดแนวนอน แสดงผลคำอธิบายอีกหน้า
      var canUse = MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top;
      setHeight = canUse;
      showDetail = false;
      textPaintSize=15.0;//15.0
      setWidth = setHeight*1.3713;
      pushCenter = (MediaQuery.of(context).size.width/2) - (setWidth/2);
      pushCenter = double.parse(pushCenter.toStringAsFixed(2));
      calPart = (setWidth/11)*3;
      part = calPart;

      if(setHeight*1.3713 > MediaQuery.of(context).size.width){//กรณีไอแพดแนวตั้ง
        print('h >> w');
        canUse = (MediaQuery.of(context).size.width*(3/4))/1.3713;
        setHeight = canUse;
        showDetail = true;
        textPaintSize=15.0;
        setWidth = setHeight*1.3713;
        pushCenter=(MediaQuery.of(context).size.width/2) - (setWidth/2);
        pushCenter = double.parse(pushCenter.toStringAsFixed(2));
        calPart = (setWidth/11)*3;
        part = calPart;
        padHint = MediaQuery.of(context).size.height/4;
      }
      

        
      var a= AppBar().preferredSize.height;
      var top =MediaQuery.of(context).padding.top;
      print("head padding : $a Top : $top");
      print("canUse : $canUse");





      // setHeight = 400.0;
      // setWidth = setHeight*1.3713;
      // pushCenter = (MediaQuery.of(context).size.width/2) - (setWidth/2);
      // pushCenter = double.parse(pushCenter.toStringAsFixed(2));
      // calPart = (setWidth/11)*3;
      // part = calPart;

      // print(double.parse((part * setWidth).toStringAsFixed(2)));
      // calPart = (part * setWidth)/411.4285;
      // setWidth = 411.42857142857144;
      // setHeight = 300.0;
      // part = 112.2077921;

    }
    else if(MediaQuery.of(context).size.width< 411.42857142857144){ // cal new size
      padHint = MediaQuery.of(context).size.height/4;
      showDetail = true;
      arrowPad = 0.0;
      textPaintSize=12.0;

      var calHeight = (MediaQuery.of(context).size.width*300)/411.42857142857144;
      setWidth = MediaQuery.of(context).size.width;
      setHeight = calHeight;
      part = 112.2077921;
      calPart = (part * setWidth)/411.42857142857144;
      part = calPart;

      pushCenter=0;
    }
    else{
      print("device width : 411.42857142857144");
      padHint = MediaQuery.of(context).size.height/4;
      arrowPad = 0.0;
      setWidth = 411.42857142857144;
      setHeight = 300.0;
      pushCenter=0;
      textPaintSize=12.0;
      showDetail = true;

      part = 112.2077921;
    }

    // w 411, h 300 ==> part =112.2077921
    // part = 112.2077921;
    textScale = MediaQuery.of(context).textScaleFactor;// default => 1
    if(textSet == false){
      textSize = textSize/textScale;
      textSet = true;
    }
    textSize = double.parse(textSize.toStringAsFixed(2));

    // setWidth = 411.42857142857144.w;
    // setHeight = 300.0.h;
    calPad = (100.0/300.0) * setHeight;

    
    print("");
    print("padding hint : $padHint");

    print("width device : ${MediaQuery.of(context).size.width}");
    print("height device : ${MediaQuery.of(context).size.height}");
    // double.parse(part.toStringAsFixed(2));
    print("part set : $part");
    print("calPart : $calPart");
    print("setWidth : $setWidth");
    print("setHeight : $setHeight");
    print("pushCenter : $pushCenter");
    print("textSize : $textSize");
    print("");
  }

  void _scollNext(){
    if(_controller.hasClients){
      // print("_controller.hasClients : ${_controller.hasClients}");
      _controller.animateTo(_controller.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 800), 
      curve: Curves.fastOutSlowIn);
    }
    
  }

  void _scollBack(){
    if(_controller.hasClients){
      _controller.animateTo(0.0, 
      duration: const Duration(milliseconds: 800), 
      curve: Curves.fastOutSlowIn);
    }

  }

  // update(){
  //   var req = widget.req;

  //   imgInfos = req; //เอาข้อมูลยัดเอง
  //   keyImg = [];
  //   for (var item in imgInfos[0].keys) {
  //     keyImg.add(item);
  //     // break;
  //   }

  //   imgNow = imgInfos[0]['animal']['0']['completeImagePath'][0];
  //   des = imgInfos[0]['animal']['0']['description'].toString();
  //   // print("imgnow is :$imgNow");

  //   setState(() {
  //     _loading = false;
  //   });
  //   return imgInfos;
  // }

  paintManual() {
    positionX = 0.0;
    positionY = 0.0;
    startX = 0.0;
    startY = 0.0;
    lineToX = 0.0;
    lineToY = 0.0;
    textX = 0.0;
    textY = 0.0;
    title = ' ';
    tagAll = [];
    print(" ---- Clear Static value is done !! ---- ");
    print(" ---- PaintManual start !! ---- ");
    // เอาขนาดเดิมมาใส่ List ให้เรียกใช้ได้ง่าย
    if (keyImg.contains(imgNow) == true) {
      /* ************************************* */
      // print("imginfo :"+imgInfos[0].toString());
      // print(imgInfos[0][imgNow]['0']);
      for (var i = 0; i < imgInfos[0][imgNow].length; i++) {
        startX = imgInfos[0][imgNow][i.toString()]['lineStartX'].toDouble();
        startY = imgInfos[0][imgNow][i.toString()]['lineStartY'].toDouble();
        lineToX = imgInfos[0][imgNow][i.toString()]['lineToX'].toDouble();
        lineToY = imgInfos[0][imgNow][i.toString()]['lineToY'].toDouble();
        title = imgInfos[0][imgNow][i.toString()]['title'];
        positionX = imgInfos[0][imgNow][i.toString()]['positionX'].toDouble();
        positionY = imgInfos[0][imgNow][i.toString()]['positionY'].toDouble();


          textX = positionX;
          textY = positionY;

        tagAll.add({
          "startX": startX,
          "startY": startY,
          "lineToX": lineToX,
          "lineToY": lineToY,
          "textX": textX,
          "textY": textY,
          "title": title
        });
      } // end for
    } else {
      // print("drag to pic : $dragToPic");
      startX = 0.0;
      startY = 0.0;
      lineToX = 0.0;
      lineToY = 0.0;
      textX = 0.0;
      textY = 0.0;
      title = ' ';
      tagAll.add({
        "startX": startX,
        "startY": startY,
        "lineToX": lineToX,
        "lineToY": lineToX,
        "textX": textX,
        "textY": textY,
        "title": title
      });
    }

    // print(" ---- PaintManual is done !! ---- ");
    // print("");
    // print("tagAll : ");
    // for (var i = 0; i < tagAll.length; i++) {
    //   print("    ${tagAll[i]["title"]}");
    //   print("        x: ${tagAll[i]["startX"]}");
    //   print("        y: ${tagAll[i]["startY"]}");
    // }
    // print("");

    var delX = setWidth/411.42857142857144;
    var delY = setHeight/300.0;
    for (var i = 0; i < tagAll.length; i++) {
      var x =tagAll[i]["startX"] * delX;
      var y = tagAll[i]["startY"] * delY;
      var toX = tagAll[i]["lineToX"] * delX;
      var toY = tagAll[i]["lineToY"] * delY;
      var tx = tagAll[i]["textX"] * delX;
      var ty = tagAll[i]["textY"] * delY;

      x = double.parse(x.toStringAsFixed(2));
      y = double.parse(y.toStringAsFixed(2));
      toX = double.parse(toX.toStringAsFixed(2));
      toY = double.parse(toY.toStringAsFixed(2));
      tx = double.parse(tx.toStringAsFixed(2));
      ty = double.parse(ty.toStringAsFixed(2));


      if(MediaQuery.of(context).size.width>411.42857142857144){
        // print("<<<<<<441");
        if(widget.animalName=='Arapaima'){
          switch (tagAll[i]["title"]) {
            case 'skull':{ty= toY-35.0;} break;
            case 'posteriorDorsalFin':{ty= toY-35.0;} break;
            case 'vertebralSpine':{ty= toY-35.0;} break;
            case 'vertebra':{ty= toY-35.0;} break;
            case 'pectoral gridle':{tx= toX-88.5;} break;
            case 'pectoralFin':{tx = toX-70.0;} break;
            // case '':{} break;
            default:break;
          }
        }
        else if(widget.animalName=='BarkingDeer'){
          switch (tagAll[i]["title"]) {
            case 'skull':{ty= toY-35.0;} break;
            case 'scapular':{tx = toX-50.0; ty = toY-35.0;} break;
            case 'humerus':{ty = toY-35.0;} break;
            case 'pelvic':{ty = toY-35.0;} break;
            case 'sarcum':{ty = toY-35.0;} break;
            case 'coccygeal':{tx = tx-10.0; ty = toY-35.0;} break;
            case 'femur':{ty = toY-20.0;} break;
            // case '':{} break;
            default:break;
          }
        }
        else if(widget.animalName=='BengalTiger'){
          switch (tagAll[i]["title"]) {
            case 'ribsCage':{ty= toY-35.0;} break;
            case 'radias':{ty = toY-35.0;} break;
            case 'sternum':{tx = toX-70.0;} break;
            case 'cervicalVertebrae':{ty = toY-35.0;} break;
            case 'femur':{tx = toX-70.0;} break;
            case 'pelvic':{ty = toY-35.0;} break;
            // case '':{} break;
            default:break;
          }
        }

        
      }
      

      // var qUP = double.parse((setHeight/2).toStringAsFixed(2));
      // var qLEFT = double.parse((setWidth/2).toStringAsFixed(2));

      // if(tx < qLEFT && ty <=qUP){//q1
      //   print("q1");
      //   print("$tx < $qLEFT && $ty <= $qUP");
      //   tx = toX - (title.length * 8) / 2 - 10;
      //   ty = toY - 30;
      // }

      // else if(tx > qLEFT && ty <=qUP){//Q2
      //   print("q2");
      //   print("$tx >= $qLEFT && $ty <= $qUP");
      //   tx = toX + 1.0;
      //   ty = toY - 30.0;
      // }

      // else if(tx >= qLEFT && ty >qUP){//Q3
      //   print("q3");
      //   print("$tx >= $qLEFT && $ty < $qUP");
      //   // textX = lineToX + 1.0;
      //   // textY = lineToY + 0;
      //   tx = tx;
      //   ty = ty;
      // }

      // else{
      //   print("q4");
      //   print("$tx < $qLEFT && $ty => $qUP");
      //   // textX = positionX - (title.length * 8.0) / 2 - 30;
      //   tx = tx;
      //   ty = ty;
      // }

      // if (tx < 1) {
      //ปรับให้ตัวแท็กไม่ตกขอบ
      // toX = toX + textX.abs();
      // textX = textX + textX.abs()+10;
      // print("");
      // }


//           if(positionX < qLEFT && positionY <=qUP){//Q1
//           print("q1");
//           print("$positionX < $qLEFT && $positionY <= $qUP");
//             textX = lineToX - (title.length * 8) / 2 - 10;
//             textY = lineToY - 30;
//           }

//           else if(positionX > qLEFT && positionY <=qUP){//Q2
//           print("q2");
//           print("$positionX >= $qLEFT && $positionY <= $qUP");
//             textX = lineToX + 1.0;
//             textY = lineToY - 30.0;
//           }

//           else if(positionX >= qLEFT && positionY >qUP){
//             print("q3");
//             print("$positionX >= $qLEFT && $positionY < $qUP");
//             // textX = lineToX + 1.0;
//             // textY = lineToY + 0;
//             textX = positionX;
//             textY = positionY;
//           }

//           else{
//             print("q4");
//             print("$positionX < $qLEFT && $positionY => $qUP");
//             // textX = positionX - (title.length * 8.0) / 2 - 30;
//             textX = positionX;
//             textY = positionY;
//           }

//           if (textX < 1) {
//           //ปรับให้ตัวแท็กไม่ตกขอบ
//           lineToX = lineToX + textX.abs();
//           textX = textX + textX.abs()+10;
//           print("");
      

      tagAll[i]["startX"] = x;
      tagAll[i]["startY"] = y;
      tagAll[i]["lineToX"] = toX;
      tagAll[i]["lineToY"] = toY;
      tagAll[i]["textX"] = tx;
      tagAll[i]["textY"] = ty;
    }

    print("");
    print("delX : ${delX.toStringAsFixed(2)}");
    print("delY : ${delY.toStringAsFixed(2)}");
    print("tagAll After modify : ");
    // print(tagAll.length);
    for (var i = 0; i < tagAll.length; i++) {
      print("    ${tagAll[i]["title"]}");
      print("        tx: ${tagAll[i]["textX"]}");
      print("        ty: ${tagAll[i]["textY"]}");
    }
    print("");

    return CustomPaint(
      painter: TPaint(),
    );
  }

  @override
  void initState() {
    super.initState();
    getImg();
    delayLoad();
  }

  @override
  Widget build(BuildContext context) {
    name = widget.animalName;
    // update();
    //411.42857142857144
    set(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return 
    ScreenUtilInit(
      designSize: const Size(428, 929),//a50
      // designSize: const Size(1080, 2340),
      minTextAdapt: true,
      builder: (context , child){
        return

      
    WillPopScope(
      onWillPop: () async {
        // print("pop");
        setState(() {
          // imgNow ='';
          // des='';
          dragToPic = 0;
          keyImg = [];
          imgInfos[0]['animal']['0']['scienceName'] = '';
          imgInfos[0]['animal']['0']['englishName'] = '';
          errorMoveX = 0.0;
          errorMoveY = 0.0;
          userMoveConditionY = 0.0;
          stackRang = 0.0;
          yDrag[0] = 0.0;
          yDrag[1] = 0.0;
          drag[0] = 0.0;
          drag[1] = 0.0;
          stackUp = 0.0;
          userDrag = 0.0;
          dragIndex = 0;
          radiant = 0.0;
          // _visible = false;
          pad = 0.0;
        });
        // return Future.value(true);
        Navigator.pop(context);
        return Future.value(false);
      },
      child: 
      Scaffold(
        appBar:
            AppBar(
          title: Text(widget.animalName),
          backgroundColor: Colors.black,
        ),
        body: 
        SingleChildScrollView( 
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _controller,
          child:

          Row(
            children:[

          Stack(
          children: <Widget>[

          Container(
            color: Colors.black,
            //color: Colors.lightBlue[300],
            padding: EdgeInsets.fromLTRB(0, pad, 0, 0),
            width: MediaQuery.of(context).size.width,
            // width: 411.42857142857144,
            alignment: Alignment.topLeft,
            child: 
            SizedBox(
              height: setHeight,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(width: pushCenter),
                  Container(
                    color: Colors.black,
                    // color: Colors.white70,
                    width: setWidth,
                    height: setHeight,
                    child: 
                    Cube(onSceneCreated: (Scene scene) {
                      scene.world.add(Object(fileName: 'assets/${widget.model}.obj'));
                      // scene.world.add(Object(fileName: 'assets/fishEdit.obj'));
                      a = scene.camera;
                      // scene.camera.trackBall(Vector2(0.0, 0.0), Vector2(205.5, 0.0));
                      scene.camera.zoom = 10;
                    }),
                  ),
                ],
              ),
            ),
            
            // Container(
            //   color: Colors.black,
            //   // color: Colors.white70,
            //   width: setWidth,
            //   height: setHeight,
            //   child: 
            //   Cube(onSceneCreated: (Scene scene) {
            //     scene.world.add(Object(fileName: 'assets/${widget.model}.obj'));
            //     a = scene.camera;
            //     // scene.camera.trackBall(Vector2(0.0, 0.0), Vector2(205.5, 0.0));
            //     scene.camera.zoom = 10;
            //   }),
            // ),
            
          ),

          Positioned(//box not allow rotate 3d model
            child: 
          Container( 
            color: const Color.fromARGB(1, 255, 255, 255),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: 
            GestureDetector(
              onHorizontalDragUpdate: (details){ // + ==> drag is left to right
                // print(details.primaryDelta);
                // print(details.primaryDelta.runtimeType);
                if(details.primaryDelta! < 0.0){ //if details.primaryDelta is negative
                  print("<==");//right to left
                  if(showDetail == false){
                    _scollNext();
                  }
                  
                }
              },
            ),
          ),),

          Positioned(
            // height: 100,
            left: pushCenter,
            child: Container(
              height: setHeight,
              width: MediaQuery.of(context).size.width - pushCenter,
              alignment: Alignment.topLeft,
              child: 
              paintManual(),
              // color: Colors.amber[100],
              // // color: Color(0xFF0E3311).withOpacity(0.1),
              // // color: const Color(0x00000000),
              // width: MediaQuery.of(context).size.width,
              // // height: 100,
              // alignment: Alignment.topLeft,
            ),
          ),

          Positioned(
            // left: 0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                height: (130.0*setHeight /300)+arrowPad,//130(normal)+50(ipad Padding) ==> 180
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [

                // Flexible(child: 
                SizedBox(width: pushCenter),
                // ),

                // Flexible(child: 
                IconButton(//left h:48 w:48
                  icon: const Icon(Icons.arrow_back_ios),
                  tooltip: 'Previous tag',
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (dragToPic == 0) {//
                      // print('lenght');
                      // print(imgInfos[0]['animal']['0']
                      //               ['completeImagePath']
                      //           .length);
                        dragToPic = imgInfos[0]['animal']['0']
                                    ['completeImagePath']
                                .length -
                            2;
                        // dragToPic=10;
                      } else {
                        dragToPic -= 1;
                      }

                      imgNow = imgInfos[0]['animal']['0']['completeImagePath']
                          [dragToPic];

                      // stackRang = dragToPic * (width * 3 / 11);// original
                      stackRang = dragToPic*part;
                      degree = dragToPic * 30.0;

                      showTagNext = stackRang;
                      a.trackBall(
                          Vector2(showTagNow, 0.0), Vector2(showTagNext, 0.0));
                      showTagNow = showTagNext;
                      // print("stack rang force rotete left : $stackRang");
                      // print("Pic : $dragToPic");
                    });
                  },
                  iconSize: (30.0*setHeight /300),
                ),
                // ),

                // Flexible(child: 
                Container(
                  // width: MediaQuery.of(context).size.width- 96
                  width: setWidth-96,
                ),
                // ),

                // Flexible(child: 
                IconButton(//right h:48 w:48
                  icon: const Icon(Icons.arrow_forward_ios),
                  tooltip: 'Next tag',
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      if (dragToPic == 10) {
                        dragToPic = 0;
                      } else {
                        dragToPic += 1;
                      }

                      imgNow = imgInfos[0]['animal']['0']['completeImagePath']
                          [dragToPic];

                      // stackRang = dragToPic * (width * 3 / 11);// original
                      stackRang = dragToPic * part;
                      degree = dragToPic * 30.0;

                      showTagNext = stackRang;
                      a.trackBall(
                          Vector2(showTagNow, 0.0), Vector2(showTagNext, 0.0));
                      showTagNow = showTagNext;
                    });
                    // print("stack rang force rotete right : $stackRang");
                    // print("Pic : $dragToPic");
                    // print("imgnow is :$imgNow");
                  },
                  iconSize: (30.0*setHeight /300),
                ),
                // ),

                
              ]),
              
              
              if(showDetail)...[
              Container(height: (140.0*setHeight /300)+arrowPad,),//140+50 ==> 190
              
            //   Container(
            //   height: 300,
            //   width: 360,
            //   // padding: const EdgeInsets.all(10.0),
            //   decoration: BoxDecoration(
            //     // color: Colors.white,
            //     border: Border.all(color: Colors.white60, width: 5),
            //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            //   ),
            // ),

              Padding( //Description หน้า Smartphone
                padding: const EdgeInsets.only(left: 10),
                child: 
                Container(
                // height: MediaQuery.of(context).size.height-450 - (arrowPad*2),
                height: (MediaQuery.of(context).size.height - 
                  AppBar().preferredSize.height - 
                  MediaQuery.of(context).padding.top) -setHeight-20,
                // height: 331.h,
                width: MediaQuery.of(context).size.width-20,
                // width: 390*ratioWidth,
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.amber, width: 5),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: 
                // SingleChildScrollView(
                //     // padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                //     scrollDirection: Axis.vertical,
                //     child: 
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("",style:TextStyle(fontSize: ScreenUtil().setSp(textSize))),
                        Text(
                            "English Name : ${imgInfos[0]['animal']['0']['englishName']}",
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(textSize),//25
                                // fontSize: 21,
                                color: Colors.black),
                            textAlign: TextAlign.center),
                        Text(
                            "Scientific Name : ${imgInfos[0]['animal']['0']['scienceName']}",
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil().setSp(textSize),//25
                                color: Colors.black),
                            textAlign: TextAlign.center),
                        Text("",style:TextStyle(fontSize: ScreenUtil().setSp(textSize))),
                        Expanded(
                          child: SingleChildScrollView(
                                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                                scrollDirection: Axis.vertical,
                                child: 
                                Text(
                                  "          $des",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(textSize),//20
                                      color: Colors.black),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                        ),
                      ],
                    ),
                  // ),
                ),
                
              ),
              
              ]

            ]),
          ),

          // Positioned( //textsize
          //   right: 10,
          //   child:
          //   // Text(
          //   //   "Tsize : $textSize , Tsc : $textScale",
          //   //   style:TextStyle(
          //   //       fontWeight: FontWeight.bold,
          //   //       fontSize: ScreenUtil().setSp(18),//25
          //   //       // fontSize: 21,
          //   //       color: Colors.white),
          //   //   textAlign: TextAlign.center),
          //   Text(
          //     "AppBarsize : ${AppBar().preferredSize.height} Top : ${MediaQuery.of(context).padding.top}",
          //     style:TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: ScreenUtil().setSp(18),//25
          //         // fontSize: 21,
          //         color: Colors.white),
          //     textAlign: TextAlign.center),
          //   ),

          if(_dialogShowHeight == true && showDetail == true)...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color:const Color.fromARGB(200, 0, 0, 0),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0, padHint, 0, 0),
              child: 
                Container(
                  constraints: BoxConstraints( 
                    maxWidth: MediaQuery.of(context).size.width*3/4,
                    maxHeight: MediaQuery.of(context).size.height*3/4
                    ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.amber, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: 
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: 
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(hint,style:TextStyle(fontSize: textSize)),
                            ),
                          ),
                      // Container(
                      //   padding: const EdgeInsets.all(16.0),
                      //   alignment: Alignment.center,
                      //   width: MediaQuery.of(context).size.width*3/4,
                      //   child: Text(hint,style:TextStyle(fontSize: ScreenUtil().setSp(textSize)))
                      // ),
                      TextButton(
                        onPressed: () => {
                          print("press (hint)!"),
                          setState(() {
                            _dialogShowHeight = false;
                          })
                          },
                        child: const Text("เข้าใจแล้ว",style:TextStyle(fontSize: 20)),
                      ),
                    ]),
                ),
              ),
            
          ],
          if(_dialogShowWidth == true && showDetail == false)...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color:const Color.fromARGB(200, 0, 0, 0),
              child: 
                Center(
                  child: Container(
                    constraints: BoxConstraints( 
                      maxWidth: MediaQuery.of(context).size.width*3/4,
                      maxHeight: MediaQuery.of(context).size.height*3/4
                      ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.amber, width: 5),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: 
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                          child: 
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(hint2,style:TextStyle(fontSize: textSize)),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          child: 
                          TextButton(
                            onPressed: () => {
                              print("press (hint2)!"),
                              setState(() {
                                _dialogShowWidth = false;
                              })
                              },
                            child: const Text("เข้าใจแล้ว",style:TextStyle(fontSize: 25)),
                          ),
                        ),
                        
                      ]),
                  ),
                ),
              ),
          ],

          /*

          // Positioned(
          //   left: 10,
          //   bottom: 10,
          //   width: 370,
          //   height: MediaQuery.of(context).size.height / 2 - 10,
          //   child: Visibility(
          //     visible: !_visible,
          //     child: Container(
          //       // color: Colors.white,
          //       padding: const EdgeInsets.all(10.0),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border.all(color: Colors.white60, width: 5),
          //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          //       ),
          //       child: Column(
          //         children: [
          //           Text(
          //               "English Name : ${imgInfos[0]['animal']['0']['englishName']}",
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 21,
          //                   color: Colors.black),
          //               textAlign: TextAlign.center),
          //           Text(
          //               "Science Name : ${imgInfos[0]['animal']['0']['scienceName']}",
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 21,
          //                   color: Colors.black),
          //               textAlign: TextAlign.center),
          //           const Text(""),
          //           Expanded(
          //             child: SingleChildScrollView(
          //               padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          //               scrollDirection: Axis.vertical,
          //               child: Text(
          //                 "          $des",
          //                 style: const TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 20,
          //                     color: Colors.black),
          //                 textAlign: TextAlign.left,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Positioned( //right arrow
          //   top: width/2 + 40 + pad -100,
          //   right: 10,
          //   child:
          //   Visibility(
          //     visible: !_visible,
          //     child:
          //       IconButton(
          //       icon: const Icon(Icons.arrow_forward_ios),
          //       tooltip: 'Next tag',
          //       color: Colors.white,
          //       onPressed: () {
          //         setState(() {
          //           if(dragToPic==11){
          //             dragToPic = 0;}
          //           else{dragToPic +=1;}

          //           imgNow = imgInfos[0]['animal']['0']['completeImagePath'][dragToPic];

          //           stackRang = dragToPic*(width*3 / 11);
          //           degree = dragToPic*30.0;

          //           showTagNext = stackRang;
          //           a.trackBall(Vector2(showTagNow, 0.0), Vector2(showTagNext, 0.0));
          //           showTagNow = showTagNext;
          //         });
          //         print("stack rang force rotete : $stackRang");
          //       },
          //       iconSize: 30.0,
          //     ),
          //     ),

          //   ),

          // Positioned( //left arrow
          // top: width/2 + 40 + pad - 100,
          // left: 10,
          // child:
          // Visibility(
          //     visible: !_visible,
          //     child:
          //     IconButton(
          //       icon: const Icon(Icons.arrow_back_ios),
          //       tooltip: 'Previous tag',
          //       color: Colors.white,
          //       onPressed: () {
          //         setState(() {
          //           if(dragToPic==0){
          //             dragToPic = imgInfos[0]['animal']['0']['completeImagePath'].length-1;}
          //           else{dragToPic -=1;}

          //           imgNow = imgInfos[0]['animal']['0']['completeImagePath'][dragToPic];

          //           stackRang = dragToPic*(width*3 / 11);
          //           degree = dragToPic*30.0;

          //           showTagNext = stackRang;
          //           a.trackBall(Vector2(showTagNow, 0.0), Vector2(showTagNext, 0.0));
          //           showTagNow = showTagNext;
          //           // print(dragToPic);
          //           });
          //       },
          //       iconSize: 30.0,
          //     ),
          //   ),
          // ),

          // Positioned(
          //   // top: 0,
          //   // left: 60,
          //   right: 1,
          //   child: 
          //   Column(
          //     children: [
          //       Text("width : ${MediaQuery.of(context).size.width}" ,
          //       style: 
          //       const TextStyle(color: Colors.white,)
          //       ),
          //       Text("height : ${MediaQuery.of(context).size.height}",
          //       style: 
          //       const TextStyle(color: Colors.white,)
          //       ),
          //       Text("width ratio : $ratioWidth" ,
          //       style: 
          //       const TextStyle(color: Colors.white,)
          //       ),
          //       Text("height ratio : $ratioHeight",
          //       style: 
          //       const TextStyle(color: Colors.white,)
          //       ),

          //     ]
          //   )
            
          // ),
          */
          
          Visibility(
            visible: _loading,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child: LoadingBouncingGrid.square(
                  size: 100.0,
                ),
              ),
            ),
          ),
        ]),

          Container( //page Description (width axis)
            color: Colors.black,
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            child: 
            // Stack(
            //   children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onHorizontalDragUpdate: (details){ // + ==> drag is left to right
                  if(details.primaryDelta! > 0.0){ //if details.primaryDelta is positive
                    print("==>");//left to right
                    _scollBack();
                  }},
                  child: 
                
                Center(
                  child: 
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width*(3/4),
                      maxHeight: MediaQuery.of(context).size.height),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.amber, width: 5),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      
                    
                    // height: MediaQuery.of(context).size.height,
                    // width: MediaQuery.of(context).size.width*(3/4),
                    
                    child: Column(children: [
                        Text("",style:TextStyle(fontSize: ScreenUtil().setSp(textSize))),
                        Text(
                            "English Name : ${imgInfos[0]['animal']['0']['englishName']}",
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:textSize,//25
                                // fontSize: 21,
                                color: Colors.black),
                            textAlign: TextAlign.center),
                        Text(
                            "Scientific Name : ${imgInfos[0]['animal']['0']['scienceName']}",
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:textSize,//25
                                color: Colors.black),
                            textAlign: TextAlign.center),
                        Text("",style:TextStyle(fontSize: textSize)),

                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                            scrollDirection: Axis.vertical,
                            child: Text(
                              "          $des",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: textSize,//20
                                  color: Colors.black),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ),


                ),

                ),

            // ]),
          ),
          
          ]),
        ),


      )
    );


    } // screenUtilInit builder
    );
  }
}

class TPaint extends CustomPainter {
  late Paint _paint;
  Offset p1 = const Offset(0.0, 0.0);
  Offset p2 = const Offset(0.0, 0.0);
  // double aaa;
  TPaint() {
    // print("Tpaint ----------");
    // print(" double aaa is ::: "+ aaa.toString());
  }
  @override
  //device width 411.42857142857144
  //device height 891.4285714285714
  // 411,891
  void paint(Canvas canvas, Size size) {
    var tagAll = _AnimalPageState.tagAll;
    // var pad = _AnimalPageState.pad;
    for (var i = 0; i < tagAll.length; i++) {
      var x =tagAll[i]["startX"];
      var y = tagAll[i]["startY"];
      var toX = tagAll[i]["lineToX"];
      var toY = tagAll[i]["lineToY"];
      var tx = tagAll[i]["textX"];
      var ty = tagAll[i]["textY"];

      var name ='';
      var temp =0.95;
      if(tagAll[i]["title"] == name){
        print(name);
        print('x : $x');
        print('y : $y');
        // print('tox : $toX');
        print('toy : $toY');
        // print('tx : $tx');
        print('ty : $ty');
        print('');
        // x=238.15;
        // y=280.19;
        // toX = 385.0;
        toY = 291.44;
        // tx = 610.0;
        ty = 287.27;

        // print('x change to : ${x/2.55}');
        // print('y change to : ${y/2.55}');
        // print('tox change to : ${toX/2.55}');
        // print('toy change to : ${toY/2.55}');
        // print('x change to : ${x/temp}');
        print('toy change to : ${toY/temp}');
        print('ty change to : ${ty/temp}');
      }

      p1 = Offset(
          // tagAll[i]["startX"], tagAll[i]["startY"] - 100.0 + pad // original
          // tagAll[i]["startX"], tagAll[i]["startY"] - calPad
          x, y - calPad
          ); //start
      p2 = Offset(
          // tagAll[i]["lineToX"], tagAll[i]["lineToY"] - 100.0 + pad // original
          // tagAll[i]["lineToX"], tagAll[i]["lineToY"] - calPad
          toX, toY - calPad
          ); //stop
      _paint = Paint()
        // ..color = Colors.white
        ..color = Colors.red
        ..strokeWidth = 2;
      canvas.drawLine(p1, p2, _paint);

      TextSpan span = TextSpan(
          style: TextStyle(color: Colors.white, fontSize: textPaintSize),//12
          text: tagAll[i]["title"]);

      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textScaleFactor: 2,
          textDirection: TextDirection.ltr);

      tp.layout();
      tp.paint(
          canvas, 
          // Offset(tagAll[i]["textX"], tagAll[i]["textY"] - 100 + pad)// original
          // Offset(tagAll[i]["textX"], tagAll[i]["textY"] - calPad)
          Offset(tx, ty - calPad)
          );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
