
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientDetailsMobile extends StatefulWidget {
  DocumentSnapshot snapshot;
  PatientDetailsMobile(this.snapshot);
  @override
  _PatientDetailsMobileState createState() => _PatientDetailsMobileState();
}

class _PatientDetailsMobileState extends State<PatientDetailsMobile> {

  final TextStyle labelTextStyle = TextStyle(
      fontSize: 15,
      color: Color(0xff1e272e));
  final TextStyle headingTextStyle = TextStyle(
      fontSize: 19,
      color: Colors.red,fontWeight: FontWeight.bold);


  String requirementDate,requirement,requiredUnits,patientName,patientAge,
      purpose,hospitalName,hospitalCityName,hospitalAreaName,requiredBloodGrp,
      roomNumber;

  bool activePost;

  String _url = "https://play.google.com/store/apps/details?id=app.helpinghands";
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  void initState() {
    super.initState();
    print(Uri.dataFromString(window.location.href));
    // print(widget.snapshot.data());
    if(widget.snapshot != null && widget.snapshot.data() != null){
      activePost = widget.snapshot["active"];
      patientName = widget.snapshot["patientName"];
      requiredBloodGrp = widget.snapshot["requiredBloodGrp"];
      patientAge =  widget.snapshot["patientAge"];
      purpose =  widget.snapshot["purpose"];
      hospitalName =  widget.snapshot["hospitalName"];
      hospitalCityName =  widget.snapshot["hospitalCity"];
      hospitalAreaName =  widget.snapshot["hospitalArea"];
      requirementDate = DateFormat('dd MMM yy, hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
              widget.snapshot["bloodRequiredDateTime"].millisecondsSinceEpoch));
      requirement =  widget.snapshot["requirementType"];
      requiredUnits = widget.snapshot["requiredUnits"];
      roomNumber =  widget.snapshot["hospitalRoomNo"];
    }
  }


  Widget lableContainer(String lable, String fillText) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.28,
            child: Text(
                lable,
              style: labelTextStyle
            ),
          ),
          Container(
            child: Text(
              ":",
              style: labelTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.46,
            child: Text(
              fillText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: labelTextStyle
            ),
          ),
        ],
      ),
    );
  }



  Widget buildRequiredDetails() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            "Requirement Details",
            style: headingTextStyle
          ),
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableContainer("Required", requirement.toUpperCase()),
              lableContainer("Required By", requirementDate),
              lableContainer("Blood Group", requiredBloodGrp),
              lableContainer("Required Units", requiredUnits + " units"),
            ],
          ),
        ],
      ),
    );
  }


  Widget buildPatientDetails() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            "Patient Details",
            style: headingTextStyle
          ),
          SizedBox(
            height: ScreenUtil().setHeight(25),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableContainer("Patient Name", patientName),
              lableContainer("Age", patientAge + " yr"),
              lableContainer("Purpose", purpose),
            ],
          ),
        ],
      ),
    );
  }



  Widget buildLocationDetails() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hospital Details",
            style: headingTextStyle
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableContainer("Hosp. Name", hospitalName),
              lableContainer("Hosp. City ", hospitalCityName),
              lableContainer("Hosp. Area ", hospitalAreaName),
              // "roomNumber" != null && "roomNumber" != ""
              //     ? lableContainer("Hospital Room No.", "roomNumber".toString())
              //     : Container(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().setHeight(30),),
          Image.asset('images/weblogo.png', fit: BoxFit.contain,height:107),
          // Text("HELPING HANDS",style: TextStyle(
          //     color: Colors.red,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 22,
          // ),),
          // SizedBox(height: 3,),
          // Text("DONATE AND SAVE",style: TextStyle(
          //     color: Colors.grey[400],
          //     fontWeight: FontWeight.bold,
          //     fontSize: 14,
          //     letterSpacing: 2.7
          // ),),Text("HELPING HANDS",style: TextStyle(
          //     color: Colors.red,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 22,
          // ),),
          // SizedBox(height: 3,),
          // Text("DONATE AND SAVE",style: TextStyle(
          //     color: Colors.grey[400],
          //     fontWeight: FontWeight.bold,
          //     fontSize: 14,
          //     letterSpacing: 2.7
          // ),),
          SizedBox(height: 20,),
          // Image.asset('images/mother.jpg', fit: BoxFit.contain,height: 100,),
          Text(
            '\"Helping hands are better than praying lips\"',
            style: TextStyle( letterSpacing: .5,
                fontSize: 12,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 5,),
          Text(
            '- Mother Teresa',
            textAlign: TextAlign.center,
            style: TextStyle( letterSpacing: .5,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
          ),
          SizedBox(height: 17,),
          Text("Patient Details",style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5,
              decoration: TextDecoration.underline
          ),textAlign: TextAlign.left,),
          // lableContainer(
          //     "Status",
          //     documentSnapshot.data()["active"] == true
          //         ? "Active"
          //         : "Not Active"),
          SizedBox(height: ScreenUtil().setHeight(30),),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(20),),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Status",
                                style: labelTextStyle
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(30),),
                          Row(
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                    color: activePost ? Colors.greenAccent:Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              SizedBox(
                                  width: ScreenUtil().setWidth(10)
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  activePost ? "Active":"Not active",
                                  style: labelTextStyle,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                buildRequiredDetails(),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                buildPatientDetails(),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                buildLocationDetails(),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: _launchURL, child: Text(
                          "I'll Donate"
                      ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)
                                )
                            )
                        ),),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Download our app!",style: TextStyle(
                color: Colors.grey
              ),),
              SizedBox(height: ScreenUtil().setHeight(10),),
              GestureDetector(
                onTap: _launchURL,
                child: Image.asset("images/googleplay.png",
                  height: ScreenUtil().setHeight(180),),
              ),
              // Image.asset("images/playstore.png",
              //   height: ScreenUtil().setHeight(110),)
            ],
          ),
          SizedBox(height: 80,),
        ],
      ),
    );
  }
}
