
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:url_launcher/url_launcher.dart';


class PatientDetailsDesktop extends StatefulWidget {
  DocumentSnapshot snapshot;
  PatientDetailsDesktop(this.snapshot);
  @override
  _PatientDetailsDesktopState createState() => _PatientDetailsDesktopState();
}

class _PatientDetailsDesktopState extends State<PatientDetailsDesktop> {

  final TextStyle labelTextStyle = TextStyle(
      fontSize: 20, color: Color(0xff1e272e));
  final TextStyle headingTextStyle = TextStyle(
      fontSize: 27,
      color: Colors.red,fontWeight: FontWeight.bold);


String requirementDate,requirement,requiredUnits,patientName,patientAge,
    purpose,hospitalName,hospitalCityName,hospitalAreaName,requiredBloodGrp,
    roomNumber;

bool activePost;

  String _url = "https://play.google.com/store/apps/details?id=app.helpinghands";
  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';


  Widget lableContainer(String lable, String fillText) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.18,
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
            width: MediaQuery.of(context).size.width*0.18,
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
            height: ScreenUtil().setHeight(30),
          ),
          Column(
            children: [
              lableContainer("Required", requirement.toUpperCase()),
              lableContainer("Required By", requirementDate.toString()),
              lableContainer("Blood Group", requiredBloodGrp.toString()),
              lableContainer("Required Units", requiredUnits.toString() + " units"),
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
            height: ScreenUtil().setHeight(30),
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
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            "Hospital Details",
            style: headingTextStyle
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lableContainer("Hospital Name", hospitalName),
              lableContainer("Hospital City Name", hospitalCityName),
              lableContainer("Hospital Area Name", hospitalAreaName),
              // ("roomNumber" != null || "roomNumber" != "")
              //     ? lableContainer("Hospital Room No.", roomNumber.toString())
              //     : Container(),
            ],
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context,
      height: 1920, // Optional
      width: 1080, // Optional
      allowFontScaling: true, // Optional
    );
    return Container(
      width: MediaQuery.of(context).size.width * 0.54,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/weblogo.png', fit: BoxFit.contain,height:160),
          // Text("HELPING HANDS",style: TextStyle(
          //     color: Colors.red,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 40,
          //     letterSpacing: 1.5
          // ),),
          // SizedBox(height: 3,),
          // Text("DONATE AND SAVE",style: TextStyle(
          //     color: Colors.grey[400],
          //     fontWeight: FontWeight.bold,
          //     fontSize: 23,
          //     letterSpacing: 4
          // ),),
          SizedBox(height: 30,),
          // Image.asset('images/mother.jpg', fit: BoxFit.contain,height: 100,),
          Text(
            '\"Helping hands are better than praying lips\"',
            style: TextStyle( letterSpacing: .5,
            fontSize: 15,
            fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 8,),
          Text(
            '- Mother Teresa',
            style: TextStyle( letterSpacing: .5,
                fontSize: 19,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
          ),
          // Text("Helping hands are better than praying lips",style: GoogleFo),
          SizedBox(height: ScreenUtil().setHeight(30),),
          Text("Patient Details",style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 1.5,
              decoration: TextDecoration.underline
          ),textAlign: TextAlign.left,),
          SizedBox(height: ScreenUtil().setHeight(20),),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(20)
            ),
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
                          SizedBox(width: 30,),
                          Row(
                            children: [
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                    color: activePost ?
                                    Colors.greenAccent:Colors.red,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    activePost ? "Active":"Not active",
                                    style: labelTextStyle
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
                  height: ScreenUtil().setHeight(20),
                ),
                buildPatientDetails(),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                buildLocationDetails(),
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: _launchURL, child: Padding(
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(29,),),
                        child: Text(
                            "I'll Donate",
                          style: TextStyle(fontSize: 20),
                        ),
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

          SizedBox(height: ScreenUtil().setHeight(40),),
          Text("Download our new app!",style: TextStyle(
              color: Colors.grey
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: _launchURL,
                child: Image.asset("images/googleplay.png",
                  height: 100),
              ),
              // Image.asset("images/playstore.png",
              //   height: ScreenUtil().setHeight(200),)
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(100),
          ),
        ],
      ),
    );
  }
}
