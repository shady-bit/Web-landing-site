import 'package:bd_web/ScreenType/patientDetailDesktop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'ScreenType/patientDetailMobile.dart';
import 'ScreenType/patientDetailTablet.dart';

class LandingPage extends StatefulWidget {
  String postId;

  LandingPage(this.postId);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Stream _stream;
  final _fireStore = FirebaseFirestore.instance;
  DocumentSnapshot postSnapshot;

  Future getPostDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Post")
        .doc(widget.postId)
        .get();

    if (mounted) {
      setState(() {
        this.postSnapshot = snapshot;
      });
    }
  }

  @override
  void initState() {
    print("Initstate called");
    super.initState();
    // precacheImage(AssetImage("images/weblogo.png"),context);
    getPostDetails();
    print(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    // ResponsiveWidgets.init(context,
    //   height: 1920, // Optional
    //   width: 1080, // Optional
    //   allowFontScaling: true, // Optional
    // );
    return ResponsiveWidgets.builder(
        height: 1920, // Optional
        width: 1080, // Optional
        allowFontScaling: true, // Optional
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(child:
                  ResponsiveBuilder(builder: (context, sizingInformation) {
                print("Screen Type: ${sizingInformation.deviceScreenType}");
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.desktop) {
                  if (postSnapshot != null && postSnapshot.data() != null) {
                    return PatientDetailsDesktop(postSnapshot);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.tablet) {
                  if (postSnapshot != null && postSnapshot.data() != null) {
                    return PatientDetailsTablet(postSnapshot);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }

                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile) {
                  if (postSnapshot != null && postSnapshot.data() != null) {
                    return PatientDetailsMobile(postSnapshot);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }

                return Container(color: Colors.purple);
              })),
            ),
          ),
        ));
  }
}
