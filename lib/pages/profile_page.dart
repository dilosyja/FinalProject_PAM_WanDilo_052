import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/services/user_preferences.dart';
import 'package:final_project/widget/numbers_widget.dart';
import 'package:final_project/widget/profile_widget.dart';
import 'package:final_project/pages/home.dart';
import 'package:final_project/message.dart';
import 'package:super_bottom_navigation_bar/super_bottom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _imagePath;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _imagePath = UserPreferences.myUser.imagePath;
  }

  Future<void> checkPermissionAndOpenCamera() async {
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
      getImageFromCamera();
    } else {
      "Ditolak";
    }
  }


  Future<void> getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        _imagePath = imageFile.path; // Menampilkan hasil jepretan kamera sebagai foto profil
      });
      saveImage(imageFile); // Menyimpan foto ke galeri setelah diambil dari kamera
    }
  }

  Future<void> saveImage(File imageFile) async {
    final result = await ImageGallerySaver.saveFile(imageFile.path);
    print(result); // Path to the saved file in the gallery
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "My",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Marhey',
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Profile!",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontFamily: 'Marhey',
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 35),
            ProfileWidget(
              imagePath: _imagePath,
              // Panggil fungsi checkPermissionAndOpenCamera saat foto profil ditekan
              onClicked: () => checkPermissionAndOpenCamera(),
            ),
            const SizedBox(height: 35),
            buildName(user),
            const SizedBox(height: 60),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(user),
          ],
        ),
      ),
      bottomNavigationBar: SuperBottomNavigationBar(
        height: 60,
        currentIndex: _currentIndex,
        items: [
          SuperBottomNavigationBarItem(
            unSelectedIcon: Icons.home_outlined,
            selectedIcon: Icons.home_outlined,
            size: 30,
            backgroundShadowColor: Colors.yellowAccent,
            borderBottomColor: Colors.yellowAccent,
            borderBottomWidth: 3,
            highlightColor: Colors.yellowAccent,
            splashColor: Colors.yellowAccent,
            selectedIconColor: Colors.yellowAccent,
            unSelectedIconColor: Colors.yellowAccent,
          ),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.message_outlined,
              selectedIcon: Icons.message_outlined,
              size: 30,
              backgroundShadowColor: Colors.yellowAccent,
              borderBottomColor: Colors.yellowAccent,
              borderBottomWidth: 3,
              highlightColor: Colors.yellowAccent,
              splashColor: Colors.yellowAccent,
              selectedIconColor: Colors.yellowAccent,
              unSelectedIconColor: Colors.yellowAccent),
          SuperBottomNavigationBarItem(
              unSelectedIcon: Icons.person_outline,
              selectedIcon: Icons.person_outline,
              size: 30,
              backgroundShadowColor: Colors.yellowAccent,
              borderBottomColor: Colors.yellowAccent,
              borderBottomWidth: 3,
              highlightColor: Colors.yellowAccent,
              splashColor: Colors.yellowAccent,
              selectedIconColor: Colors.yellowAccent,
              unSelectedIconColor: Colors.yellowAccent),
        ],
        onSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()));
          } else if (index == 2) {
          }
        },
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Comic'),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.black87, fontSize: 16),
      )
    ],
  );

  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'Comic'),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 17, height: 1.4),
        ),
      ],
    ),
  );
}