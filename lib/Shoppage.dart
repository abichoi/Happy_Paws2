import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'dart:html' as html;

class ShopPage extends StatefulWidget {
  @override
  State<ShopPage> createState() => _ShopPageState();
}


class _ShopPageState extends State<ShopPage> {
  String _selected = "dog";
  late Uri url;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Shop"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.greenAccent,Colors.indigoAccent],
                ),
              ),
            )
        ),
        body: SingleChildScrollView(
            child:Column(
            children: <Widget>[
              const Text(' ', style: TextStyle(fontSize: 8)),
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    url = Uri.parse("https://www.petshop.co.uk/");
                    _launchURL();
                  },
                  child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3,
                        shadowColor: Colors.black,
                        child: Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage('assets/Petshopco.jpg'),
                                      radius: 60,
                                    ),
                                  )
                              ),
                              const Expanded(
                                  flex: 7,
                                  child:ListTile(
                                    title: Text("PetShop.co.uk"),
                                    subtitle: Text("premium pet foods, cheap dog foods, holistic cat food, puppy food, pet treats, cat litter, pet beds and pet clothes and accessories"),
                                  )),
                            ]
                        ),
                  )),
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    url = Uri.parse("https://www.petplanet.co.uk/");
                    _launchURL();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black,
                    child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                // alignment: Alignment.centerLeft,
                                child: CircleAvatar(
                                  child: Image.asset('assets/petplanet.jpg'),
                                  radius: 60,
                                ),
                              )
                          ),
                          const Expanded(
                              flex: 7,
                              child:ListTile(
                                title: Text("petplanet.co.uk"),
                                subtitle: Text("Retailer of Pet Products for Dogs, Cats, Fish and Small animals. Part of M8 Group, recognised as one of the UKs fastest growing profitable private companies through its inclusion in the Sunday Times Fast Track 100 index published in November 2010."),
                              )),
                        ]
                    ),
                  )),
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    url = Uri.parse("https://www.petsathome.com/");
                    _launchURL();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black,
                    child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/Pets_at_Home.jpg'),
                                  radius: 60,
                                ),
                              )
                          ),
                          const Expanded(
                              flex: 7,
                              child:ListTile(
                                title: Text("Pets at Home"),
                                subtitle: Text("Pets at Home offers the ultimate pet shop experience. It really is a paradise for pets and pet owners. We have all the pet supplies, pet food, toys and accessories you and your pet need at great value prices. "),
                              )),
                        ]
                    ),
                  )),
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    url = Uri.parse("https://www.zooplus.co.uk/");
                    _launchURL();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black,
                    child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const CircleAvatar(
                                  backgroundImage: AssetImage('assets/zooplus.png'),
                                  radius: 60,
                                ),
                              )
                          ),
                          const Expanded(
                              flex: 7,
                              child:ListTile(
                                title: Text("Zooplus"),
                                subtitle: Text("zooplus offers a full range of pet supplies for you and your pets - over 8,000 top products in stock and ready to ship. With over 17 years of expertise in pet food and pet accessories, you can expect top brands and quality products at amazing low prices."),
                              )),
                        ]
                    ),
                  )),
              InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    url = Uri.parse("https://www.thepetexpress.co.uk/");
                    _launchURL();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black,
                    child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: CircleAvatar(
                                  child: Image.asset('assets/thepetexpress.png'),
                                  radius: 60,
                                ),
                              )
                          ),
                          const Expanded(
                              flex: 7,
                              child:ListTile(
                                title: Text("The Pet Express"),
                                subtitle: Text("Our online store comprises of over 18,000 quality products for all pets including dogs, cats, reptiles, birds, small pets and fish. Our excellent relationships with the industry’s biggest suppliers allows us to offer this wide range of products at great prices."),
                              )),
                        ]
                    ),
                  )),
                ]
        ))
    );
  }

  _launchURL() async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }


}