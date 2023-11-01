
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';
import 'package:whatsapp_clone_app/features/user/presentation/pages/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(child: Text("Welcome to WhatsApp Clone", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tabColor),),),
            Image.asset("assets/bg_image.png"),
            Column(
              children: [
                const Text("Read our Privacy Policy Tap, 'Agree and Continue' to accept the Team of Service.", textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tabColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text("AGREE AND CONTINUE", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
