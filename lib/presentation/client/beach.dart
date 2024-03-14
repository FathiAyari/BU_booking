import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umbrella/models/Umbrella.dart';
import 'package:umbrella/presentation/Authentication/Sign_in/components/umbrellaWidget.dart';
import 'package:umbrella/presentation/ressources/colors.dart';
import 'package:umbrella/presentation/ressources/dimensions/constants.dart';

class Beach extends StatefulWidget {
  const Beach({Key? key}) : super(key: key);

  @override
  State<Beach> createState() => _BeachState();
}

class _BeachState extends State<Beach> {
  var user=GetStorage().read('user');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Constants.screenHeight * 0.1,
                width: Constants.screenWidth,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primary.withOpacity(0.5)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row
                    (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bienvenue  : ${user['name'].toString().toUpperCase()}  ${user['lastName'].toString().toUpperCase()}",
                        style: TextStyle(color: Colors.white, fontSize: 20,fontStyle: FontStyle.italic),
                      ),
                      Spacer(),
                      Image.asset(user['role']=="admin" ?"assets/images/admin.png":"assets/images/user.png")

                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('umbrellas').orderBy('index', descending: false).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Umbrella> umbrellas = [];
                      for (var data in snapshot.data!.docs.toList()) {
                        umbrellas.add(Umbrella.fromJson(data.data() as Map<String, dynamic>));
                      }
                      if (umbrellas.isNotEmpty) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1, crossAxisCount: 8, mainAxisSpacing: 5, crossAxisSpacing: 10),
                                    padding: EdgeInsets.all(1.0),
                                    itemCount: umbrellas.length ~/ 2,
                                    itemBuilder: (context, index) {
                                      return UmbrellaWidget(umbrella: umbrellas[index]);
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        Icons.arrow_forward,
                                        color: Colors.green,
                                      );
                                    }),
                                  ),
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1, crossAxisCount: 8, mainAxisSpacing: 5, crossAxisSpacing: 10),
                                    padding: EdgeInsets.all(1.0),
                                    itemCount: umbrellas.length ~/ 2,
                                    itemBuilder: (context, index) {
                                      return UmbrellaWidget(
                                          umbrella: umbrellas.sublist(umbrellas.length ~/ 2, umbrellas.length)[index]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                child: Transform.rotate(
                                    angle: 1.5708,
                                    child: Text(
                                      "Plage",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
/*
Center(
child: ElevatedButton(
onPressed: () {
List values = [
'F1,1',
'F2,1',
'F3,1',
'F4,1',
'F5,1',
'F6,1',
'F7,1',
'F8,1',
'F1,2',
'F2,2',
'F3,2',
'F4,2',
'F5,2',
'F6,2',
'F7,2',
'F8,2',
'F1,3',
'F2,3',
'F3,3',
'F4,3',
'F5,3',
'F6,3',
'F7,3',
'F8,3',
'F1,4',
'F2,4',
'F3,4',
'F4,4',
'F5,4',
'F6,4',
'F7,4',
'F8,4',
'F1,5',
'F2,5',
'F3,5',
'F4,5',
'F5,5',
'F6,5',
'F7,5',
'F8,5',
'F1,6',
'F2,6',
'F3,6',
'F4,6',
'F5,6',
'F6,6',
'F7,6',
'F8,6',
'F1,7',
'F2,7',
'F3,7',
'F4,7',
'F5,7',
'F6,7',
'F7,7',
'F8,7',
'F1,8',
'F2,8',
'F3,8',
'F4,8',
'F5,8',
'F6,8',
'F7,8',
'F8,8',
'F1,9',
'F2,9',
'F3,9',
'F4,9',
'F5,9',
'F6,9',
'F7,9',
'F8,9',
'F1,10',
'F2,10',
'F3,10',
'F4,10',
'F5,10',
'F6,10',
'F7,10',
'F8,10',
'F1,11',
'F2,11',
'F3,11',
'F4,11',
'F5,11',
'F6,11',
'F7,11',
'F8,11',
'F1,12',
'F2,12',
'F3,12',
'F4,12',
'F5,12',
'F6,12',
'F7,12',
'F8,12',
'F1,13',
'F2,13',
'F3,13',
'F4,13',
'F5,13',
'F6,13',
'F7,13',
'F8,13',
'F1,14',
'F2,14',
'F3,14',
'F4,14',
'F5,14',
'F6,14',
'F7,14',
'F8,14',
'F1,15',
'F2,15',
'F3,15',
'F4,15',
'F5,15',
'F6,15',
'F7,15',
'F8,15',
'F1,16',
'F2,16',
'F3,16',
'F4,16',
'F5,16',
'F6,16',
'F7,16',
'F8,16',
'F1,17',
'F2,17',
'F3,17',
'F4,17',
'F5,17',
'F6,17',
'F7,17',
'F8,17',
'F1,18',
'F2,18',
'F3,18',
'F4,18',
'F5,18',
'F6,18',
'F7,18',
'F8,18',
'F1,19',
'F2,19',
'F3,19',
'F4,19',
'F5,19',
'F6,19',
'F7,19',
'F8,19',
'F1,20',
'F2,20',
'F3,20',
'F4,20',
'F5,20',
'F6,20',
'F7,20',
'F8,20',
'F1,21',
'F2,21',
'F3,21',
'F4,21',
'F5,21',
'F6,21',
'F7,21',
'F8,21',
'F1,22',
'F2,22',
'F3,22',
'F4,22',
'F5,22',
'F6,22',
'F7,22',
'F8,22',
'F1,23',
'F2,23',
'F3,23',
'F4,23',
'F5,23',
'F6,23',
'F7,23',
'F8,23',
'F1,24',
'F2,24',
'F3,24',
'F4,24',
'F5,24',
'F6,24',
'F7,24',
'F8,24',
'F1,25',
'F2,25',
'F3,25',
'F4,25',
'F5,25',
'F6,25',
'F7,25',
'F8,25',
'F1,26',
'F2,26',
'F3,26',
'F4,26',
'F5,26',
'F6,26',
'F7,26',
'F8,26',
'F1,27',
'F2,27',
'F3,27',
'F4,27',
'F5,27',
'F6,27',
'F7,27',
'F8,27',
'F1,28',
'F2,28',
'F3,28',
'F4,28',
'F5,28',
'F6,28',
'F7,28',
'F8,28',
'F1,29',
'F2,29',
'F3,29',
'F4,29',
'F5,29',
'F6,29',
'F7,29',
'F8,29',
'F1,30',
'F2,30',
'F3,30',
'F4,30',
'F5,30',
'F6,30',
'F7,30',
'F8,30',
'F1,31',
'F2,31',
'F3,31',
'F4,31',
'F5,31',
'F6,31',
'F7,31',
'F8,31',
'F1,32',
'F2,32',
'F3,32',
'F4,32',
'F5,32',
'F6,32',
'F7,32',
'F8,32',
'F1,33',
'F2,33',
'F3,33',
'F4,33',
'F5,33',
'F6,33',
'F7,33',
'F8,33',
'F1,34',
'F2,34',
'F3,34',
'F4,34',
'F5,34',
'F6,34',
'F7,34',
'F8,34',
'F1,35',
'F2,35',
'F3,35',
'F4,35',
'F5,35',
'F6,35',
'F7,35',
'F8,35',
'F1,36',
'F2,36',
'F3,36',
'F4,36',
'F5,36',
'F6,36',
'F7,36',
'F8,36'
];
for (int index = 0; index < values.length; index++) {
FirebaseFirestore.instance
    .collection('umbrellas')
    .doc(values[index])
    .set(Umbrella(idUmbrella: values[index], price: 0, index: index).toJson());
}
*/
/*            values.map((e) {
              FirebaseFirestore.instance.collection('umbrellas').doc(e).set(Umbrella(idUmbrella: e, price: 0,index: ).toJson());
              //  FirebaseFirestore.instance.collection('users').doc(e).delete();
            }).toList();*/ /*

},
child: Text("click"),
),
),*/
