// ignore_for_file: avoid_print

// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:anibone/widget/loading.dart';

class ModelView extends StatefulWidget {
  const ModelView({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ModelViewState createState() => _ModelViewState();
}

final list = ['Arapaima', 'BarkingDeer', 'BengalTiger']; //'porcupine'
final model = ['Arapaima', 'BarkingDeer2', 'tiger'];
final id = [
  // '60bd7a09269a0d4674c937e9',
  // '6038b9d7ff0829223c34adb1',
  // '6038be53ff0829223c34adbc',
  '6167e926247565c88d2a1837',
  '6167e76b247565c88d2a1835',
  '6167e7c9247565c88d2a1836'
];


class _ModelViewState extends State<ModelView> {
  @override
  Widget build(BuildContext context) {
    // original
    return Scaffold(
      appBar:
          AppBar(
        title: const Text('3D Model',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            // return _tile(c[index].englishName, c[index].id);
            return ListTile(
              title: Text(list[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.black)),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    // builder: (value) => AnimalPage(
                    builder: (value) => Loading(
                          animalName: list[index],
                          // id: id[index],
                          model: model[index],
                        ));
                Navigator.push(context, route);
              },
            );
          }),
    );
  }

  }
// }

  Scaffold buildPhoneLayout(BuildContext context, bool tabletMode) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Model',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.black)),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    // builder: (value) => AnimalPage(
                    builder: (value) => Loading(
                          animalName: list[index],
                          // id: id[index],
                          model: model[index],
                        ));
                Navigator.push(context, route);
              },
            );
          }),
    );
  }


/* didn't use for not connect DB
class Animal {
  final String id;
  final String thaiName;
  final String englishName;
  final bool bone;
  final bool completeImage;
  final String model;

  Animal(
      {required this.id,
      required this.thaiName,
      required this.englishName,
      required this.bone,
      required this.completeImage,
      required this.model});

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
        id: json['_id'],
        thaiName: json['thaiName'],
        englishName: json['englishName'],
        bone: json['bone'],
        completeImage: json['completeImage'],
        model: json['model']);
  }
}*/

// Real IP DB         : "http://202.28.24.50:3000/animal/get-all-animal-name" --- อันนี้ฝั่งสัตวแพทย์ปิดเซฟอยู่
// P pond DB On Local : "http://localhost:3000/animal/get-all-animal-name"  --- ใช้อันนี้ทดสอบไปก่อน
//"http://192.168.1.103:3000/animal/get-all-animal-name"
// My DB              : "http://localhost:4000/getAnimalName" --อันนี้ที่ทำเอง
