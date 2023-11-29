import 'package:final_project/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/pages/home.dart';
import 'package:super_bottom_navigation_bar/super_bottom_navigation_bar.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<String> _items = [
    'Pesan : Mau ngucapin terima kasih banget buat kuliah pemrograman mobilenya yang super keren! \nSaya bener-bener jadi tau bahwa mengerjakan codingan mobile butuh effort lebih dibanding ngedeketin dia. Tapi gapapa disini saya jadi tahu penyebab immune tubuh menurun dan bisa belajar cara menjaga kesehatan. ^_^',
    'Kesan : Pak Bagus baik, kelas nya asik, yang jahat cuman Mata Kuliah nya. Tapi apapun itu terimakasih Pak Bagus atas didikannya dan sudah mengajari saya arti dari kerasnya kehidupan. Semoga dengan hasil aplikasi dan presentasi saya hari ini bisa membantu absensi saya yang sering ketiduran dan lupa asben kelas AAMIIIINNN'
  ];

  int _currentIndex = 1; // Index navigasi untuk MessagePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pesan",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Marhey',
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Kesan!",
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
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.yellowAccent, Colors.yellow.withOpacity(1)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Card(
                          elevation: 8.0,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/login.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                _items[index],
                                style: TextStyle(
                                  fontFamily: 'Comic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              trailing: Icon(Icons.favorite, color: Colors.black87),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
          }
        },
      ),
    );
  }
}
