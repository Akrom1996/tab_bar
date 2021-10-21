import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "E'lonlar",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          actions: [
            Center(
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10, top: 4),
                    child: Icon(
                      Icons.notifications_rounded,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.deepOrangeAccent),
                      child: const Text(
                        "12",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
          bottom: TabBar(
            unselectedLabelStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1),
            labelStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepOrangeAccent,
            tabs: const [
              Tab(
                text: "Xabarlar",
              ),
              Tab(text: "Bildirishnomalar"),
            ],
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index)=>Container(
                height: 100,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 4,bottom: 2),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.9),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text("$index")),
              ),)
            ),
            Center(
              child: Text("2"),
            ),
          ],
        ),
      ),
    );
  }
}
