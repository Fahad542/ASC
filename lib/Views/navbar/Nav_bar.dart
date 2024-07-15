import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uvento/Views/Home/home.dart';
import '../Attendies/Attendies_view.dart';
import '../Awards/Awards_view.dart';


class Navbar extends StatefulWidget {
   int index;
   String img;
  Navbar({ required this.index, required this.img});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  void img(String imgs) {
     widget.img=imgs;
  }
  static List<Widget> widgetopt = [

    HomeScreen(),
    Attendies(),
    Awards(),
  ];



  void _onTabChange(int index) {
    setState(() {
      widget.index = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: widgetopt[widget.index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xff102733),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            backgroundColor: Color(0xff102733),
            color: Colors.white,
            activeColor: Colors.black,
            tabBackgroundColor: Color(0xffFCCD00),
            padding: EdgeInsets.all(14),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
                iconColor: Colors.white,
                iconActiveColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              GButton(
                icon: Icons.person,
                text: "Attendies",
                iconColor: Colors.white,
                iconActiveColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon:Icons.emoji_events ,
                text: "Awards",
                iconColor: Colors.white,
                iconActiveColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            selectedIndex: widget.index,
            onTabChange: _onTabChange,
          ),
        ),
      ),
    );
  }
}