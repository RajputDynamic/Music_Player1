import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/Screens/Sign-UpScreens/sign_in_screen.dart';

import '../repository/Authentication_repo/AuthenticationRepository.dart';
class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min, // compact height
          children: [
            Text(
              "Are you sure?",
              style: TextStyle(fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Do you really want to logout?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text("No", style: TextStyle(
                      fontSize: screenWidth * 0.05),),
                  onPressed: () {
                    Navigator.of(context).pop();// Close dialog
                  },
                ),
                InkWell(
                  onTap: () async {
                    Navigator.of(context).pop();
                    await Authentication_Repository().logout();
                    Get.offAll(()=>SignInScreen());

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.blueAccent],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text("Yes", style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}