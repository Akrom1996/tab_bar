import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:readmore/readmore.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  List<Placemark>? placemark;

  List<bool> isOpenPanel = List.generate(8, (index) => false);

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print("${position.latitude}, ${position.longitude}");
    placemark = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "en_US");
    print("placemarks: $placemark");
    print("Country: ${placemark![0].country}");
    print("Locality: ${placemark![0].locality!.replaceAll('zh', 'j')}");
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _getCurrentPosition();
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
                        "55",
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
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
            ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/image.jpg",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),

                        ReadMoreText(
                          """There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.""",
                          trimLines: 4,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: "Ko'proq",
                          trimExpandedText: "Kamroq",
                          delimiter: "..",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              height: 1.4),
                          textAlign: TextAlign.start,
                          moreStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          buttonPadding: EdgeInsets.symmetric(vertical: 0),
                          // buttonHeight: 52.0,
                          // buttonMinWidth: 90.0,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(4.0)),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.thumb_up_alt_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                Text("1000")
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(4.0)),
                                  onPressed: () {},
                                  child: Icon(Icons.thumb_down_outlined,
                                      color: Colors.black),
                                ),
                                Text("1000")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            Center(
              child: Text("2"),
            ),
          ],
        ),
      ),
    );
  }
}
