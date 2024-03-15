import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umbrella/presentation/ressources/colors.dart';
import 'package:umbrella/presentation/ressources/dimensions/constants.dart';
import 'package:umbrella/services/AuthServices.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var user = GetStorage().read('user');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Constants.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  backgroundImage: AssetImage("assets/images/img.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Constants.screenHeight * 0.1,
                    width: Constants.screenWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nom  : ${user['name'].toString().toUpperCase()}",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            "Prénom  : ${user['lastName'].toString().toUpperCase()}",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Constants.screenHeight * 0.1,
                    width: Constants.screenWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Email  : ${user['email']} ",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Constants.screenHeight * 0.1,
                    width: Constants.screenWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pays  : ${user['countryId']} ",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Constants.screenHeight * 0.1,
                    width: Constants.screenWidth,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Téléphone  : ${user['phoneNumber']} ",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: Constants.screenWidth,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
//y7zYIrbxOPSbVnndpvJAMfTTMK13,jVpe3k9OYJafJI9truhabLNYHl62,Rjhm0BtLNjg0XMTevutNiZ1b2KJ3

                       // FirebaseFirestore.instance.collection("users").doc("jVpe3k9OYJafJI9truhabLNYHl62").update({"createdAt":DateTime.now().subtract(Duration(days: 2))});
                         AuthServices().logOut(context);
                      },
                      child: Text(
                        "Déconnecter",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
