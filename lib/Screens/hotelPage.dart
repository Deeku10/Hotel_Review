// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hotel_management/heightWidth.dart';
import 'package:hotel_management/models/hotel.dart';
import 'package:hotel_management/widgets/heading.dart';
import 'package:hotel_management/models/review.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotelPage extends StatefulWidget {
  static const id = '';
  const HotelPage({Key? key, required this.hotel}) : super(key: key);
  final Hotel hotel;
  @override
  // ignore: no_logic_in_create_state
  State<HotelPage> createState() => _HotelPageState(hotel);
}

class _HotelPageState extends State<HotelPage> {
  final Hotel hotel;
  _HotelPageState(this.hotel);

  Future<List<Review>> getReviews(docName) async {
    List<Review> a = <Review>[];
    final snapshot = await FirebaseFirestore.instance
        .collection("review")
        .doc("$docName")
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data == null) {
        return a;
      } else {
        for (var e in snapshot.data()!.values) {
          a.add(Review.fromMap(e as Map<String, dynamic>));
        }
      }
    }

    return a;
  }

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    var h = context.height;
    var w = context.width;
    String heading = '';
    String comment = '';
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: t.backgroundColor,
      body: SafeArea(
        child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: w * 0.03, vertical: h * 0.02),
                height: h * 0.4,
                width: w,
                color: const Color.fromARGB(255, 155, 155, 172),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: hotel.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Heading(
                t: t,
                text: "Description",
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: w * 0.03),
                child: Text(
                  hotel.description,
                  textAlign: TextAlign.justify,
                  style: t.textTheme.headline2
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Heading(
                t: t,
                text: "Reviews",
              ),
              FutureBuilder(
                  future: getReviews(hotel.id),
                  builder: (context, AsyncSnapshot<List<Review>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                            physics: const ScrollPhysics(
                                parent: NeverScrollableScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(h * 0.02),
                                margin: EdgeInsets.symmetric(
                                    horizontal: w * 0.03, vertical: h * 0.01),
                                height: h * 0.2,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 132, 173, 209),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(h * 0.02)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        horizontalspacer(w: w * 0.1),
                                        Text(
                                          snapshot.data![index].heading,
                                          style: t.textTheme.headline2,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('review')
                                                // ignore: unnecessary_string_interpolations
                                                .doc('${hotel.id}')
                                                .update({
                                              snapshot.data![index].epoch:
                                                  FieldValue.delete()
                                            }).whenComplete(() {
                                              snapshot.data!.removeAt(index);
                                              setState(() {});
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.delete_forever),
                                          iconSize: h * 0.035,
                                        ),
                                      ],
                                    ),
                                    horizontalspacer(w: w * 0),
                                    Text(
                                      snapshot.data![index].comment,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: t.textTheme.headline3,
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            horizontalspacer(w: w),
                            Text(
                              "No Reviews Yet",
                              style: t.textTheme.headline1,
                            ),
                          ],
                        );
                      }
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          horizontalspacer(w: w),
                          // ignore: prefer_const_constructors
                          CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ],
                      );
                    }
                  }),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Add your Review",
                              style: t.textTheme.headline1,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'CANCEL',
                                  style: t.textTheme.headline3,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('review')
                                      // ignore: unnecessary_string_interpolations
                                      .doc('${hotel.id}')
                                      .update({
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString(): {
                                      'epoch': DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString(),
                                      'comment': comment,
                                      'heading': heading,
                                      'user': user.email
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ADD',
                                  style: t.textTheme.headline3,
                                ),
                              ),
                            ],
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                    // ignore: prefer_const_constructors
                                    decoration: InputDecoration(
                                      hintText: 'Enter a title for your review',
                                      labelText: 'Title',
                                    ),
                                    onChanged: (value) {
                                      heading = value;
                                    },
                                    validator: (String? value) {
                                      return (value != null &&
                                              value.length > 20)
                                          ? 'Enter a proper title (max 20)'
                                          : null;
                                    }),
                                TextFormField(
                                    // ignore: prefer_const_constructors
                                    decoration: InputDecoration(
                                      hintText: 'Enter review here',
                                      labelText: 'comment',
                                    ),
                                    onChanged: (value) {
                                      comment = value;
                                    },
                                    validator: (String? value) {
                                      return (value != null &&
                                              value.length > 197)
                                          ? 'Make sure to enter review'
                                          : null;
                                    }),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(
                    "add a review",
                    style: t.textTheme.headline3,
                  )),
            ]),
      ),
    );
  }
}
