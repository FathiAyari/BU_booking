import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:umbrella/models/Umbrella.dart';
import 'package:umbrella/models/booking.dart';
import 'package:umbrella/presentation/components/input_field/input_field.dart';
import 'package:umbrella/presentation/ressources/colors.dart';
import 'package:umbrella/presentation/ressources/dimensions/constants.dart';

class UmbrellaDetails extends StatefulWidget {
  final Umbrella umbrella;

  const UmbrellaDetails({required this.umbrella, Key? key}) : super(key: key);

  @override
  State<UmbrellaDetails> createState() => _UmbrellaDetailsState();
}

class _UmbrellaDetailsState extends State<UmbrellaDetails> {
  var user = GetStorage().read("user");

  int getDaysBetween(DateTime startDate, DateTime endDate) {
    final difference = endDate.difference(startDate);
    return difference.inDays + 1;
  }

  Future<bool> allowBooking() async {
    bool allowAction = true;
    var bookings = await FirebaseFirestore.instance
        .collection('booking')
        .where("umbrellaId", isEqualTo: widget.umbrella.idUmbrella)
        .where("status", isEqualTo: 1)
        .get();
    List<Booking> bookingList = [];
    for (var data in bookings.docs.toList()) {
      bookingList.add(Booking.fromJson(data.data()));
    }
    for (Booking booking in bookingList) {
      if ((startDate.isBefore(booking.startDate) && endDate.isAfter(booking.startDate)) ||
          (startDate.isBefore(booking.endDate) && endDate.isAfter(booking.endDate)) ||
          (startDate.isAfter(booking.startDate) && endDate.isBefore(booking.endDate)) ||
          (startDate.year == booking.startDate.year &&
              startDate.month == booking.startDate.month &&
              startDate.day == booking.startDate.day) ||
          (startDate.year == booking.startDate.year &&
              startDate.month == booking.startDate.month &&
              startDate.day == booking.startDate.day &&
              endDate.year == booking.endDate.year &&
              endDate.month == booking.endDate.month &&
              endDate.day == booking.endDate.day)) {
        allowAction = false;
      }
    }
    return allowAction;
  }

  bool loading = false;
  bool done = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TextEditingController sofaController = TextEditingController();
  TextEditingController bedController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Setter();
    allowBooking();
  }

  Setter() {
    setState(() {
      sofaController.text = "";
      bedController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "Details de parasole ",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // change this to your desired color
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary.withOpacity(0.5)),
              height: Constants.screenHeight * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "File de parasole : ${widget.umbrella.idUmbrella.split(",")[0]}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "Numéro de parasole dans le file : ${widget.umbrella.idUmbrella.split(",")[1]}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('booking')
                      .where("umbrellaId", isEqualTo: widget.umbrella.idUmbrella)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Booking> bc = [];
                      for (var data in snapshot.data!.docs.toList()) {
                        bc.add(Booking.fromJson(data.data() as Map<String, dynamic>));
                      }
                      if (bc.isNotEmpty) {
                        return ListView.builder(
                            itemCount: bc.length,
                            itemBuilder: (context, index) {
                              return BookingWidget(
                                widget: widget,
                                booking: bc[index],
                              );
                            });
                      } else {
                        return Center(
                          child: Lottie.asset("assets/lotties/empty.json"),
                        );
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Future<void> future = showModalBottomSheet<void>(
              context: context,
              isDismissible: true,
              enableDrag: true,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    width: double.infinity,
                    height: Constants.screenHeight,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: done
                            ? Column(
                                children: [
                                  Lottie.asset("assets/lotties/success.json"),
                                  Text(
                                    "Votre demande a été envoyé pour l'administrateur",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                                          )),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Fermer",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              )
                            : Column(
                                children: [
                                  InputField(
                                      prefixWidget: Icon(
                                        Icons.chair,
                                        color: AppColors.primary,
                                      ),
                                      label: "Nombre de lit : 0",
                                      textInputType: TextInputType.number,
                                      controller: bedController),
                                  InputField(
                                      prefixWidget: Icon(
                                        Icons.chair_outlined,
                                        color: AppColors.primary,
                                      ),
                                      label: " fauteuil de réalisateur : 0 ",
                                      textInputType: TextInputType.number,
                                      controller: sofaController),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.07),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              final pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: startDate,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2025),
                                              );
                                              if (pickedDate != null) {
                                                setState(() {
                                                  startDate = pickedDate;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Text(
                                                "Date debut \n ${DateFormat("yyyy/MM/dd").format(startDate)}",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            )),
                                      )),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.07),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              final pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: endDate,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2025),
                                              );
                                              if (pickedDate != null) {
                                                setState(() {
                                                  endDate = pickedDate;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Text(
                                                "Date fin \n ${DateFormat("yyyy/MM/dd").format(endDate)}",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            )),
                                      )),
                                    ],
                                  ),
                                  loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.07),
                                          child: Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  if (startDate.isAfter(endDate)) {
                                                    Fluttertoast.showToast(
                                                        msg: "La date de debut doit etre apres la date de fin de reservation",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  } else {
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    allowBooking().then((value) async {
                                                      if (value) {
                                                        var sofa = await FirebaseFirestore.instance
                                                            .collection("equipement")
                                                            .doc("sofa")
                                                            .get();
                                                        var bed = await FirebaseFirestore.instance
                                                            .collection("equipement")
                                                            .doc("bed")
                                                            .get();

                                                        num totalPrice = widget.umbrella.price;
                                                        if (sofaController.text.isNotEmpty) {
                                                          totalPrice += sofa.get('price') *
                                                              int.parse(sofaController.text) *
                                                              getDaysBetween(startDate, endDate);
                                                        }
                                                        if (bedController.text.isNotEmpty) {
                                                          totalPrice += bed.get('price') *
                                                              int.parse(bedController.text) *
                                                              getDaysBetween(startDate, endDate);
                                                        }
                                                        Booking booking = Booking(
                                                            DepositDate: DateTime.now(),
                                                            startDate: startDate,
                                                            status: 0,
                                                            clientId: user['uid'],
                                                            endDate: endDate,
                                                            sofa:
                                                                sofaController.text.isEmpty ? 0 : int.parse(sofaController.text),
                                                            bed: bedController.text.isEmpty ? 0 : int.parse(bedController.text),
                                                            umbrellaId: widget.umbrella.idUmbrella,
                                                            totalPrice: totalPrice);
                                                        FirebaseFirestore.instance
                                                            .collection("booking")
                                                            .add(booking.toJson())
                                                            .then((value) {
                                                          setState(() {
                                                            done = true;
                                                          });
                                                        });
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg: "Reservation validé deja positionné sur la meme periode",
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.CENTER,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                      }
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.green,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0), // Set the border radius here
                                                    )),
                                                child: Text(
                                                  "Ajouter",
                                                  style: TextStyle(color: Colors.white),
                                                )),
                                          ),
                                        ),
                                ],
                              ),
                      ),
                    ),
                  );
                });
              },
            );

            future.then((void value) {
              setState(() {
                loading = false;
                done = false;
                startDate = DateTime.now();
                endDate = DateTime.now();
              });
            });
          },
        ),
      ),
    );
  }
}

class BookingWidget extends StatelessWidget {
  const BookingWidget({
    super.key,
    required this.widget,
    required this.booking,
  });

  final UmbrellaDetails widget;
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary.withOpacity(0.5)),
        height: Constants.screenHeight * 0.2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date de debut :  ${DateFormat("yyyy/MM/dd").format(booking.startDate)}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Date de fin : ${DateFormat("yyyy/MM/dd").format(booking.endDate)}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Date de depot :${DateFormat("yyyy/MM/dd").format(booking.DepositDate)}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Statut : ${booking.status == 0 ? "En attente" : (booking.status == 1 ? "Confirmé" : "Refusé")}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}