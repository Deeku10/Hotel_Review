import 'package:flutter/material.dart';
import 'package:hotel_management/Screens/hotelPage.dart';
import 'package:hotel_management/models/hotel.dart';

import 'package:hotel_management/heightWidth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  static const id = "homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Hotel>> getHotels() async {
    List<Hotel> a = <Hotel>[];
    final snapshot = await FirebaseFirestore.instance
        .collection("hotel")
        .doc("hostellist")
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) {
        return a;
      }
      for (var e in data.values) {
        a.add(Hotel.fromMap(e as Map<String, dynamic>));
      }
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
    var h = context.height;
    var w = context.width;
    var t = Theme.of(context);
    return Scaffold(
      backgroundColor: t.backgroundColor,
      body: FutureBuilder(
        future: getHotels(),
        builder: (context, AsyncSnapshot<List<Hotel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: h * 0.08),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: h * 0.017, horizontal: w * 0.04),
                      height: h * 0.21,
                      width: w * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 0.017),
                        color: t.primaryColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(top: h * 0.01, left: w * 0.02),
                            height: h * 0.19,
                            width: w * 0.41,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(h * 0.017),
                              color: const Color.fromARGB(255, 158, 158, 158),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: snapshot.data![index].image,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // FittedBox(
                                //   // fit: BoxFit.contain,
                                //   child:
                                Text(
                                  snapshot.data![index].hotelName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: t.textTheme.headline2
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    horizontalspacer(w: w * 0.01),
                                    SvgPicture.asset(
                                      'assets/images/Vector.svg',
                                    ),
                                    horizontalspacer(w: w * 0.03),
                                    Expanded(
                                      child: Text(
                                        snapshot.data![index].twoPT,
                                        maxLines: 2,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        style: t.textTheme.headline2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: w * 0.32,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          snapshot.data![index].place,
                                          style: t.textTheme.headline3,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: h * 0.06,
                                      icon: SvgPicture.asset(
                                        'assets/images/arrow.svg',
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HotelPage(
                                                    hotel:
                                                        snapshot.data![index],
                                                  )),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No hotels found at the moment",
                    style: t.textTheme.headline1,
                  ),
                ],
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                horizontalspacer(w: w),
                // ignore: prefer_const_constructors
                CircularProgressIndicator(
                  color: Colors.red,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
