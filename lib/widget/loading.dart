
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:anibone/widget/animal_page.dart';
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatefulWidget {
  final String animalName;
  // final String id;
  final String model;
  // final bool tabletMode;
  const Loading(
      { Key? key,
      required this.model,
      required this.animalName,
      // required this.tabletMode,
      // required this.id
      }) // use "widget.animalName" to call data from pass
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  List<Map<String, Map<String, Map<String, dynamic>>>> fish = [
    {
      "img-1623030395678.png":{
        "0":{
          "title": "skull",
          "positionX": 62.7450,//100
          "positionY": 168.4210,//176.4705
          "lineStartX": 100.5,
          "lineStartY": 232.4631,//227.17
          "lineToX": 75.0,
          "lineToY": 190.0,
          "description": "-"
        },
      },
      "img-1623030395709.png":{
        "0":{
          "title": "operculum",
          "positionX": 86.2745,//105.26
          "positionY": 315.79,
          "lineStartX": 133.68,
          "lineStartY": 263.16,
          "lineToX": 105.26,
          "lineToY": 315.79,
          "description": "-"
        },
      },
      "img-1623030395725.png":{
        "0":{
          "title": "pelvicGridle",
          "positionX": 74.5098,//120
          "positionY": 305.8823,//310
          "lineStartX": 179.0947,//173.0
          "lineStartY": 282.15,
          "lineToX": 105.8823,//79.5
          "lineToY": 306.6,
          "description": "-"
        },
      },
      "img-1623030395740.png":{
        "0":{
          "title": "maxilla",//Q3
          "positionX": 120.0,
          "positionY": 302.3894,//280.0
          "lineStartX": 215.79,
          "lineStartY": 261.2105,//264.16
          "lineToX": 150.9803,//89.5
          "lineToY": 306.7789,//284.37
          "description": "-"
        },
        "1":{
          "title": "dentary",
          "positionX": 270.5882,//285
          "positionY": 305.8823,//310
          "lineStartX": 215.79,
          "lineStartY": 273.69,
          "lineToX": 269.5,
          "lineToY": 309.79,
          "description": "-"
        },
      },
      "img-1623030395760.png":{
        "0":{
          "title": "caudalFin",
          "positionX": 42.1052,//62.7450
          "positionY": 282.3529,//280
          "lineStartX": 137.0,
          "lineStartY": 258.68,
          "lineToX": 84.0,
          "lineToY": 283.13,
          "description": "-"
        },
      },
      "img-1623030395769.png":{
        "0":{
          "title": "pectoral gridle",
          "positionX": 221.0526,//282.3529
          "positionY": 315.79,
          "lineStartX": 273.68,
          "lineStartY": 263.16,
          "lineToX": 305.26,
          "lineToY": 315.79,
          "description": "-"
        },
      },
      "img-1623030395787.png":{
        "0":{
          "title": "vertebralSpine",
          "positionX": 247.0588,//290
          "positionY": 168.4210,//180.3921
          "lineStartX": 234.5,
          "lineStartY": 225.0,
          "lineToX": 255.5,
          "lineToY": 194.42,
          "description": "-"
        },
        "1":{
          "title": "posteriorDorsalFin",
          "positionX": 31.3725,//42
          "positionY": 147.3684,//160.7843
          "lineStartX": 168.0,
          "lineStartY": 209.57,
          "lineToX": 69.5,
          "lineToY": 172.91,
          "description": "-"
        },
        "2":{
          "title": "ribs",
          "positionX": 180.3921,//199
          "positionY": 298.0392,//297
          "lineStartX": 220.0,
          "lineStartY": 255.75,
          "lineToX": 190.0,
          "lineToY": 300.0,
          "description": "-"
        },
      },
      "img-1623030395799.png":{
        "0":{
          "title": "vertebra",
          "positionX": 243.1372,//280
          "positionY": 152.6315,//168.6274
          "lineStartX": 231.5,
          "lineStartY": 235.0,
          "lineToX": 250.5,
          "lineToY": 180.0,
          "description": "-"
        },
      },
      "img-1623030395822.png":{
        "0":{
          "title": "pectoralFin",
          "positionX": 242.1052,//296.0784
          "positionY": 323.5294,//326.32
          "lineStartX": 250.6842,//252.63
          "lineStartY": 294.9368,//297.72
          "lineToX": 294.74,
          "lineToY": 326.32,
          "description": "-"
        },
      },
      "img-1623030395837.png":{},
      "img-1623030395844.png":{
        "0":{
          "title": "analFin",
          "positionX": 274.5098,//320
          "positionY": 315.79,
          "lineStartX": 252.63,
          "lineStartY": 277.75,
          "lineToX": 284.21,
          "lineToY": 315.79,
          "description": "-"
        }
      },
      "img-1623030395858.png":{},//not use
      "animal":{
        "0":{
          "_id":"6167e926247565c88d2a1837",
          "bone2/dPath":[],
          "picturePath":[],
          "thaiName":"ปลาอะราไพม่า",
          "englishName":"Arapaima",
          "scienceName":"Arapaima gigas",
          "technicalTerm":"Arapaima gigas",
          "description":"มีรูปร่างคล้ายปลาช่อน (Channa stiata) มาก เป็นปลาที่มีขนาดใหญ่มาก เกล็ดมีขนาดใหญ่ มีสีดำเงาเป็นมัน ครีบบน ครีบล่าง มีตำแหน่งค่อนไปทางหาง มีแถบสีแดงส้ม ตัดกับพื้นสีดำ มีลำตัวค่อนข้างกลมและเรียวยาว ส่วนหัวมีลักษณะแข็งและมีน้ำหนักมาก ส่วนลำตัวด้านท้ายมีลักษณะแบนกว้าง ในขณะที่ปลายังเล็กพื้นลำตัวจะมีสีเขียวเข้ม และลำตัวส่วนที่ค่อนไปทางหางจะเป็นสีดำ และรูปร่างจะออกไปทางทรงกระบอก เมื่อโตขึ้นบริเวณลำตัวและส่วนที่ค่อนไปทางหาง ครีบ และหาง จะปรากฏสีชมพูปนแดงหรือสีบานเย็นประแต้มกระจายอยู่ทั่วไป เมื่อจวนตัว ปลาอะราไพม่าจะใช้ส่วนหัวที่แข็งพุ่งชนและกระโดดใส่ด้วยความรุนแรงเพื่อป้องกันตัว",
          "taxonomy":null,
          "animalTypeId":null,
          "__v":"0",
          "complete":true,
          "completeImagePath":["img-1623030395678.png", "img-1623030395709.png",
                              "img-1623030395725.png", "img-1623030395740.png",
                              "img-1623030395760.png", "img-1623030395769.png",
                              "img-1623030395787.png", "img-1623030395799.png",
                              "img-1623030395822.png", "img-1623030395837.png",
                              "img-1623030395844.png", "img-1623030395858.png",
                              ],
          "boneId":"61686a77fe32551c8fb754e1",
          "completeImageLink":["http://localhost:4000/img/animals/img-1623030395678.png",
                              "http://localhost:4000/img/animals/img-1623030395709.png",
                              "http://localhost:4000/img/animals/img-1623030395725.png",
                              "http://localhost:4000/img/animals/img-1623030395740.png",
                              "http://localhost:4000/img/animals/img-1623030395760.png",
                              "http://localhost:4000/img/animals/img-1623030395769.png",
                              "http://localhost:4000/img/animals/img-1623030395787.png",
                              "http://localhost:4000/img/animals/img-1623030395799.png",
                              "http://localhost:4000/img/animals/img-1623030395822.png",
                              "http://localhost:4000/img/animals/img-1623030395837.png",
                              "http://localhost:4000/img/animals/img-1623030395844.png",
                              "http://localhost:4000/img/animals/img-1623030395858.png",
                              ],
          
        }
      }
    },
  ];
  
  List<Map<String, Map<String, Map<String, dynamic>>>> deer = [
    {
      "img-1622987719538.jpg":{
        "0":{
          "title": "phalangs",
          "positionX": 39.2156,//80
          "positionY": 335.0,
          "lineStartX": 135.0,//128.5
          "lineStartY": 316.86,//316.86
          "lineToX": 80.0,//20
          "lineToY": 341.0,//341.31
          "description": "-"
        },
        "1":{
          "title": "ulnar",
          "positionX": 66.9058,//117.0
          "positionY": 282.5607,//290.0
          "lineStartX": 155.0,//155.0
          "lineStartY": 262.6,//262.6
          "lineToX": 90.0,//90.0
          "lineToY": 287.04,//287.04
          "description": "-"
        },
        "2":{
          "title": "tibia",
          "positionX": 298.0392,//340
          "positionY": 250.9803,//230
          "lineStartX": 265,//267.5
          "lineStartY": 276,//277.75
          "lineToX": 297.5,//297.5
          "lineToY": 262.0,//291.22
          "description": "-"
        },
      },
      "img-1622987719540.jpg":{
        "0":{
          "title": "toracicVertebrae",
          "positionX": 211.7647,//300
          "positionY": 160.7843,//140
          "lineStartX": 200.0,//200
          "lineStartY": 222.0,//230
          "lineToX": 217.5,//217.5
          "lineToY": 173.0,//173
          "description": "-"
        },
        "1":{
          "title": "ribsCage",
          "positionX": 207.8431,//280.0
          "positionY": 321.5686,//325.0
          "lineStartX": 192.0,//189
          "lineStartY": 240.0,//245.97
          "lineToX": 219.0,//219
          "lineToY": 320.0,//274.37
          "description": "-"
        },
      },
      "img-1622987719541.jpg":{
        // "0":{
        //   "title": "lumbarVertebrae",
        //   "positionX": 373.0,//373
        //   "positionY": 91.0,
        //   "lineStartX": 195.5,//195.5
        //   "lineStartY": 218.37,//218.37
        //   "lineToX": 221.5,//221.5
        //   "lineToY": 169.48,//169.48
        //   "description": "-"
        // },
        "0":{
          "title": "skull",
          "positionX": 110.0,//122
          "positionY": 131.5789,//145.0980
          "lineStartX": 150.0,//142.5
          "lineStartY": 188.55,//188.55
          "lineToX": 120.0,//94
          "lineToY": 160.0,//151.8
          "description": "-"
        },
      },
      "img-1622987719542.jpg":{
        "0":{
          "title": "humerus",
          "positionX": 235.2941,//290
          "positionY": 173.6842,//190.1960
          "lineStartX": 218.0,//218
          "lineStartY": 240.0,//226
          "lineToX": 243.0,//243
          "lineToY": 202.24,//202.24
          "description": "-"
        },
        "1":{
          "title": "scapular",
          "positionX": 105.2631,//141.1764
          "positionY": 147.3684,//160.7843
          "lineStartX": 200.5,//187.5
          "lineStartY": 214.95,//214.95
          "lineToX": 160.0,//114.0
          "lineToY": 173.4,//173.4
          "description": "-"
        },
      },
      "img-1622987719543.jpg":{},
      "img-1622987719544.jpg":{
        "0":{
          "title": "metacapus",
          "positionX": 100.0,//100.0
          "positionY": 335.2941,//338
          "lineStartX": 170.0,//170.0
          "lineStartY": 315.0,//315
          "lineToX": 126.0,//126
          "lineToY": 334.46,//334.466
          "description": "-"
        },
      },
      "img-1622987719546.jpg":{
        "0":{
          "title": "carpus",
          "positionX": 286.2745,//340
          "positionY": 292.1568,//290
          "lineStartX": 260.0,//265
          "lineStartY": 280.0,//283.62
          "lineToX": 285.5,//285.5
          "lineToY": 297.08,//297.08
          "description": "-"
        },
        "1":{
          "title": "pelvic",
          "positionX": 86.2745,//120
          "positionY": 136.8421,//147.0588
          "lineStartX": 160.0,//155
          "lineStartY": 215.6,//208.6
          "lineToX": 100.0,//56.5
          "lineToY": 159.71,//159.71
          "description": "-"
        },
        "2":{
          "title": "tarsus",
          "positionX": 86.2745,//100
          "positionY": 330.0,
          "lineStartX": 135.0,//140
          "lineStartY": 287.04,//287.04
          "lineToX": 100.0,//17
          "lineToY": 330.0,//311.488
          "description": "-"
        },
      },
      "img-1622987719548.jpg":{
        "0":{
          "title": "sarcum",
          "positionX": 110.0,//159
          "positionY": 152.6315,//164.7058
          "lineStartX": 160.0,//149.5
          "lineStartY": 217.39,//217.399
          "lineToX": 130.0,//48.5
          "lineToY": 178.28,//178.288
          "description": "-"
        },
      },
      "img-1622987719549.jpg":{
        "0":{
          "title": "coccygeal",
          "positionX": 105.2631,//117.6470
          "positionY": 173.6842,//186.2745
          "lineStartX": 175,//173.5
          "lineStartY": 226,//227.66
          "lineToX": 140.0,//80
          "lineToY": 200.68,//226.68
          "description": "-"
        },
      },
      "img-1622987719550.jpg":{},
      "img-1622987719552.jpg":{
        "0":{
          "title": "femur",
          "positionX": 264.7058,//320
          "positionY": 242.1052,//256.8627
          "lineStartX": 230.0,//230.0
          "lineStartY": 245.5,//245.5
          "lineToX": 265.0,//258.5
          "lineToY": 258.46,//258.466
          "description": "-"
        },
      },
      "img-1622987719553.jpg":{},
      "animal":{
        "0":{
          "_id":"615ebc1206872f9875d9dcea",
          "bone2/dPath":[],
          "picturePath":[],
          "thaiName":"เก้ง",
          "englishName":"Barking Deer",
          "scienceName":"Muntiacus muntja",
          "technicalTerm":"Muntiacus muntja",
          "description":"มีชื่อเรียกอื่นว่าหรือ อีเก้ง หรือฟาน เป็นสัตว์ในกลุ่มของกวางที่มีขนาดตัวที่เล็ก มีขนาดลำตัวยาว 90-105 เซนติเมตร สูง 50-55 เซนติเมตร หนักเพียง 20-24 กิโลกรัม ตัวผู้พบเขาสั้นสีดำ ตรงปลายแตกเป็นสองง่าม ยาวประมาณ 15 เซนติเมตร และตัวผู้โตเต็มที่มีเขี้ยวยื่นออกตรงมุมปาก ขนมีสีน้ำตาลปนแดง ท้องสีซีดอมเทา หน้าผากเป็นสัน มีขนสีดำเป็นรูปตัววี เวลาเดินจะยกขาสูง มักอาศัยอยู่บริเวณพงหญ้าตามลำพังและอยู่เป็นคู่ในช่วงฤดูผสมพันธุ์ กินใบไม้อ่อน ผลไม้ เปลือกไม้ และหน่อไม้อ่อน เป็นอาหาร จะหากินช่วงเย็นและเช้าตรู่ พบได้บริเวณเอเชียตะวันออกเฉียงใต้ และเอเชียใต้ เก้งเข้าสู่วัยเจริญพันธุ์เมื่ออายุหนึ่งปีครึ่งช่วงฤดูหนาว ออกลูกครั้งละ 1 ตัว ลูกเก้งแรกเกิดจนถึง 6 เดือนจะพบจุดสีขาวรอบลำตัว อายุเฉลี่ย 15 ปี ปัจจุบันจัดเป็นสัตว์ป่าคุ้มครอง ตามพระราชบัญญัติสงวนและคุ้มครองสัตว์ป่า พุทธศักราช 2535 ที่อนุญาตให้เพาะพันธุ์ได้",
          "taxonomy":null,
          "animalTypeId":"603677bb5eb22332cc9c8058",
          "__v":"0",
          "complete":true,
          "completeImagePath":["img-1622987719538.jpg", "img-1622987719540.jpg",
                              "img-1622987719541.jpg", "img-1622987719542.jpg",
                              "img-1622987719543.jpg", "img-1622987719544.jpg",
                              "img-1622987719546.jpg", "img-1622987719548.jpg",
                              "img-1622987719549.jpg", "img-1622987719550.jpg",
                              "img-1622987719552.jpg", "img-1622987719553.jpg",
                              ],
          "boneId":"61685a39fe32551c8fb754de",
          "completeImageLink":["http://localhost:4000/img/animals/img-1622987719538.jpg",
                              "http://localhost:4000/img/animals/img-1622987719540.jpg",
                              "http://localhost:4000/img/animals/img-1622987719541.jpg",
                              "http://localhost:4000/img/animals/img-1622987719542.jpg",
                              "http://localhost:4000/img/animals/img-1622987719543.jpg",
                              "http://localhost:4000/img/animals/img-1622987719544.jpg",
                              "http://localhost:4000/img/animals/img-1622987719546.jpg",
                              "http://localhost:4000/img/animals/img-1622987719548.jpg",
                              "http://localhost:4000/img/animals/img-1622987719549.jpg",
                              "http://localhost:4000/img/animals/img-1622987719550.jpg",
                              "http://localhost:4000/img/animals/img-1622987719552.jpg",
                              "http://localhost:4000/img/animals/img-1622987719553.jpg",
                              ],
          
        }
      }
    }
  ];
  
  List<Map<String, Map<String, Map<String, dynamic>>>> tiger= [
    {
      "img-1627658689013.jpg":{
        "0":{
          "title": "fibular",
          "positionX": 258.8235,//300
          "positionY": 329.4117,//337
          "lineStartX": 245.0,//233.5
          "lineStartY": 276.28,//276.28
          "lineToX": 265.0,//261
          "lineToY": 330.0,//289.75
          "description": "-"
        },
        "1":{
          "title": "ribsCage",
          "positionX": 196.0784,//250
          "positionY": 157.8947,//168.6874
          "lineStartX": 174.0,//171.5
          "lineStartY": 227.17,//227.17
          "lineToX": 200.0,//75.5
          "lineToY": 180.0,//191.39
          "description": "-"
        }
      },
      "img-1627658689016.jpg":{
        "0":{
          "title": "phalangs",
          "positionX": 70.5882,//100
          "positionY": 345.0980,//350
          "lineStartX": 118.0,//118
          "lineStartY": 318.33,//318.33
          "lineToX": 90.0,//39.5
          "lineToY": 345.0,//342.77
          "description": "-"
        },
        "1":{
          "title": "tarsus",
          "positionX": 313.7254,//360
          "positionY": 296.0784,//300
          "lineStartX": 240.0,//228.5
          "lineStartY": 290.0,//288.51
          "lineToX": 311.0,//311
          "lineToY": 301.97,//301.97
          "description": "-"
        },
        "2":{
          "title": "metatarsus",
          "positionX": 247.0588,//264
          "positionY": 340.0,
          "lineStartX": 230.0,//220
          "lineStartY": 302.2,//302.2
          "lineToX": 255.0,//262.5
          "lineToY": 340.0,//330.33
          "description": "-"
        },
      },
      "img-1627658689024.jpg":{
        "0":{
          "title": "humerus",
          "positionX": 63.1578,//78.4313
          "positionY": 285.0,
          "lineStartX": 168.0,//173.5
          "lineStartY": 250.86,//250.86
          "lineToX": 100.0,//75
          "lineToY": 285.08,//285.08
          "description": "-"
        },
      },
      "img-1627658689026.jpg":{
        "0":{
          "title": "scapular",
          "positionX": 254.9019,//310
          "positionY": 176.4705,//160
          "lineStartX": 221.05,
          "lineStartY": 213.0,
          "lineToX": 252.63,
          "lineToY": 188.55,
          "description": "-"
        },
      },
      "img-1627658689027.jpg":{
        "0":{
          "title": "radias",
          "positionX": 270.5882,//335
          "positionY": 289.4736,//298.0392
          "lineStartX": 233.0,//227.5
          "lineStartY": 291.44,//291.44
          "lineToX": 270.0,//257.5
          "lineToY": 304.0,//304.91
          "description": "-"
        },
      },
      "img-1627658689031.jpg":{
        "0":{
          "title": "skull",
          "positionX": 326.0,//326.0
          "positionY": 133.3333,//120
          "lineStartX": 304.0,//304.0
          "lineStartY": 169.0,//169
          "lineToX": 325.0,//325
          "lineToY": 144.55,//144.55
          "description": "-"
        },
      },
      "img-1627658689034.jpg":{
        "0":{
          "title": "sternum",
          "positionX": 168.4210,//215.6862
          "positionY": 264.0,
          "lineStartX": 236.5,//236.5
          "lineStartY": 240.6,//240.6
          "lineToX": 234.0,//266.5
          "lineToY": 265.0,//254.06
          "description": "-"
        },
        "1":{
          "title": "cervicalVertebrae",
          "positionX": 189.4736,//220.0
          "positionY": 126.3157,//143.1372
          "lineStartX": 287.0,//290
          "lineStartY": 190.24,//180.24
          "lineToX": 250.0,//200
          "lineToY": 155.8,//155.8
          "description": "-"
        },
      },
      "img-1627658689037.jpg":{
        "0":{
          "title": "femur",
          "positionX": 52.6315,//78.4313
          "positionY": 288.2352,//294
          "lineStartX": 140.0,//133.5
          "lineStartY": 254.0,//254.28
          "lineToX": 95.0,//35
          "lineToY": 290.0,//278.73
          "description": "-"
        },
        "1":{
          "title": "patella",
          "positionX": 176.4705,//185
          "positionY": 329.4117,//335
          "lineStartX": 145.0,//136.5
          "lineStartY": 274.33,//274.33
          "lineToX": 180.0,//45
          "lineToY": 330.0,//306.11
          "description": "-"
        },
        // "2":{
        //   "title": "pelvic",
        //   "positionX": 110.0,//101
        //   "positionY": 140.0,
        //   "lineStartX": 145.0,//138
        //   "lineStartY": 212.51,//212.51
        //   "lineToX": 100.0,//49.5
        //   "lineToY": 163.62,//163.62
        //   "description": "-"
        // },
      },
      "img-1627658689041.jpg":{},
      "img-1627658689042.jpg":{},
      "img-1627658689043.jpg":{
        "0":{
          "title": "pelvic",
          "positionX": 274.5098,//320
          "positionY": 136.8421,//149.0196
          "lineStartX": 254.74,
          "lineStartY": 221.05,
          "lineToX": 284.21,
          "lineToY": 163.62,
          "description": "-"
        },
      },
      "img-1627658689047.jpg":{},//not use
      "animal":{
        "0":{
          "_id":"6167e7c9247565c88d2a1836",
          "bone2/dPath":[],
          "picturePath":[],
          "thaiName":"เสือโคร่งเบงกอล",
          "englishName":"Bengal Tiger, Royal Bengal Tiger",
          "scienceName":"Panthera tigris tigri",
          "technicalTerm":"Panthera tigris tigri",
          "description":"เสือโคร่งเบงกอล เป็นเสือโคร่งที่มีขนาดใหญ่เป็นอันดับ 2 ของบรรดาเสือโคร่งทั้งหมด รองจากเสือโคร่งไซบีเรีย (Panthera tigris altaica) ที่พบในแถบไซบีเรีย ประเทศรัสเซีย เสือโคร่งเบงกอลเพศผู้เมื่อมีขนาดใหญ่เต็มที่อาจยาวได้ถึง 360 เซนติเมตร หนัก 180-270 กิโลกรัม ขณะที่ตัวเมียมีขนาดเล็กกว่า และมีน้ำหนักอยู่ที่ประมาณ 140–180 กิโลกรัม มีการกระจายพันธุ์อยู่ในภูมิภาคเอเชียใต้ ในประเทศอินเดีย เนปาล บังกลาเทศ และกระจายเข้าไปในแถบประเทศพม่าด้วย เสือโคร่งไม่อยู่เป็นคู่ นอกจากฤดูผสมพันธุ์ เป็นสัดนานประมาณ 3-6 วัน ผสมพันธุ์ได้เมื่อมีอายุ 30-36 เดือนขึ้นไป ผสมพันธุ์ได้ตลอดปี ตั้งท้องนาน 95-105 วัน ออกลูกครั้งละ 2-5 ตัว และแม่เสือจะเลี้ยงลูกเสือจนโตอายุประมาณ 2 ปี จึงจะแยกจากกัน จัดเป็นสัตว์ป่าคุ้มครอง ตามพระราชบัญญัติสงวนและคุ้มครองสัตว์ป่า พุทธศักราช 2535",
          "taxonomy":null,
          "animalTypeId":"6036780c5eb22332cc9c805d",
          "__v":"0",
          "complete":true,
          "completeImagePath":["img-1627658689013.jpg", "img-1627658689016.jpg",
                              "img-1627658689024.jpg", "img-1627658689026.jpg",
                              "img-1627658689027.jpg", "img-1627658689031.jpg",
                              "img-1627658689034.jpg", "img-1627658689037.jpg",
                              "img-1627658689041.jpg", "img-1627658689042.jpg",
                              "img-1627658689043.jpg", "img-1627658689047.jpg",
                              ],
          "boneId":"61686ac7fe32551c8fb754e2",
          "completeImageLink":["http://localhost:4000/img/animals/img-1627658689013.jpg",
                              "http://localhost:4000/img/animals/img-1627658689016.jpg",
                              "http://localhost:4000/img/animals/img-1627658689024.jpg",
                              "http://localhost:4000/img/animals/img-1627658689026.jpg",
                              "http://localhost:4000/img/animals/img-1627658689027.jpg",
                              "http://localhost:4000/img/animals/img-1627658689031.jpg",
                              "http://localhost:4000/img/animals/img-1627658689034.jpg",
                              "http://localhost:4000/img/animals/img-1627658689037.jpg",
                              "http://localhost:4000/img/animals/img-1627658689041.jpg",
                              "http://localhost:4000/img/animals/img-1627658689042.jpg",
                              "http://localhost:4000/img/animals/img-1627658689043.jpg",
                              "http://localhost:4000/img/animals/img-1627658689047.jpg",
                              ],
          
        }
      }
    }
  ]; //ยังไม่ได้แท็ก

  // ignore: prefer_typing_uninitialized_variables
  var data;

  getImg() async {
    print("");
    if (widget.animalName == "Arapaima") { data = fish;}
    if (widget.animalName == "BarkingDeer") { data = deer;}
    if (widget.animalName == "BengalTiger") { data = tiger;}
    print("model is : ${widget.model}");

    // if(widget.animalName =='...'){print('------ Loading page do nothing!!');}
    // else{
    //   print('------ Loading page receive data');
    //   print(widget.animalName);
    //   print(widget.model);

    MaterialPageRoute route = MaterialPageRoute(
        // builder: (value) => Gridview());
        builder: (value) => AnimalPage(
              animalName: widget.animalName,
              // id: widget.id,
              model: widget.model,
              // req: req,
              req: data,
            ));
    WidgetsBinding.instance.addPostFrameCallback((_){   //ถ้าไม่ได้ต่อ API ต้องเปิดบรรทัดนี้
      Navigator.pushReplacement(context, route);        //ถ้าไม่ได้ต่อ API ต้องเปิดบรรทัดนี้
    });                                                 //ถ้าไม่ได้ต่อ API ต้องเปิดบรรทัดนี้
    
    // }
  }

  @override
  void initState() {
    super.initState();
    getImg();
  }

  @override
  Widget build(BuildContext context) {
    /* original
    return
    WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return false;
      },
      child: 

        Scaffold(
      backgroundColor: Colors.white,//Colors.blue[400],
      body: Center(
          child: LoadingBouncingGrid.square(
            // borderColor: Colors.black,
            // borderSize: 5.0,
            // backgroundColor: Colors.blue[900],
            // duration: Duration(milliseconds: 2000),
            // duration: Duration(milliseconds: 100),
            size: 100.0,
          // ),
        // ),
      ),),
        ),
    );
  }*/
    
    return
    WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return false;
      },
      child: 
        Scaffold(
      backgroundColor: Colors.white,//Colors.blue[400],
      body: Center(
          child: LoadingBouncingGrid.square(
            size: 100.0,
      ),),
        ),
    );
  }
    // print("");
    // if (widget.animalName == "Arapaima") { data = fish;}
    // if (widget.animalName == "BarkingDeer") { data = deer;}
    // if (widget.animalName == "BengalTiger") { data = tiger;}
    // print("model is : ${widget.model}");
        // return 
        // AnimalPage(
        //   animalName: widget.animalName,
        //   model: widget.model,
        //   req: data,
        // );
}

Scaffold loading(BuildContext context){
  return
  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: LoadingBouncingGrid.square(
            size: 100.0,
      ),
      ),
      );
}

Scaffold nothing(BuildContext context){
  return Scaffold(
    body: Text(
              "AppBarsize : ${AppBar().preferredSize.height} Top : ${MediaQuery.of(context).padding.top}",
              style:const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  // fontSize: 21,
                  color: Colors.red),
              textAlign: TextAlign.center),
            
  );
}
