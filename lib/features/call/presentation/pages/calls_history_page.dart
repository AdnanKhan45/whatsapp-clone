
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';

import '../../../app/global/date/date_formats.dart';

class CallsHistoryPage extends StatelessWidget {
  const CallsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Recent",
                style: TextStyle(
                    fontSize: 15,
                    color: greyColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            ListView.builder(
              itemCount: 20,
            shrinkWrap: true,
            physics: const ScrollPhysics()
            ,itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: profileWidget(),
                  ),
                ),
                title: const Text("Username",  style: TextStyle(fontSize: 16),),
                subtitle: Row(
                  children: [
                    const Icon(
                     Icons.call_made,
                      color: Colors.green,
                      size: 19,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(formatDateTime(DateTime.now())),
                  ],
                ),
                trailing: const Icon(
                  Icons.call,
                  color: tabColor,
                ),
              );
            })
          ],
        ),
      )
    );
  }
}
