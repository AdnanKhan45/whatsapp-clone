import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/features/app/const/page_const.dart';
import 'package:whatsapp_clone_app/features/app/global/date/date_formats.dart';
import 'package:whatsapp_clone_app/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: profileWidget(),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 8,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: tabColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(width: 2, color: backgroundColor)),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My status",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Tap to add your status update",
                    style: TextStyle(color: greyColor),
                  )
                ],
              )),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.myStatusPage);
                },
                child: Icon(
                  Icons.more_horiz,
                  color: greyColor.withOpacity(.5),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Recent updates",
              style: TextStyle(
                  fontSize: 15, color: greyColor, fontWeight: FontWeight.w500),
            ),
          ),

          const SizedBox(height: 10,),

          ListView.builder(
            itemCount: 10,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  margin: const EdgeInsets.all(3),
                  width: 55,
                  height: 55,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: profileWidget(),
                  ),
                ),
                title: const Text(
                  "Username",
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                    formatDateTime(DateTime.now())),
              );
          })
        ],
      ),
    ));
  }
}
