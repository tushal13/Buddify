import 'package:buddify/views/screen/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'image_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(
              margin: EdgeInsets.only(left: 15),
              child: CircleAvatar(
                child: Lottie.network(
                  'https://lottie.host/b15cb9e5-8e43-4390-815d-03727037680a/l6H48yj8Pw.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.08,
                  animate: true,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            title: Text(
              'Buddify',
              style: GoogleFonts.kodchasan(
                  fontSize: 22,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            pinned: true,
            floating: true,
            bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text(
                    'Chat',
                    style: GoogleFonts.kodchasan(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  icon: Icon(
                    CupertinoIcons.chat_bubble_2,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  child: Text(
                    'Creative',
                    style: GoogleFonts.kodchasan(
                        fontSize: 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  icon: Icon(Icons.image_outlined, color: Colors.white),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
              child: TabBarView(
            controller: _tabController,
            children: [
              ChatPage(),
              ImagePage(),
            ],
          ))
        ],
      ),
    );
  }
}
