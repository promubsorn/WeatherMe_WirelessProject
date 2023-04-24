import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import '../airPollution.dart';
import '../TempMap.dart';
import '../searchWeather.dart';
import '../weatherMap.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InfoCard(
                        title: "WeatherMe",
                        caption: "Keep calm and winter on!"),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, top: 24, bottom: 10),
                      child: Text(
                        "Browse".toUpperCase(),
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .titleMedium!
                        //     .copyWith(color: Colors.black),
                      ),
                    )
                  ]),
              decoration: BoxDecoration(
                  // color:
                  //     Colors.white, //just mark the position dont forget to change
                  ),
            ),
            navItem(
              icon: Icon(Icons.home),
              title: 'Home',
              nextPage: MyHomePage(),
            ),
            navItem(
              icon: Icon(Icons.search),
              title: 'Search Weather',
              nextPage: SearchWeather(),
              // nextPage: JobsState(),
            ),
            navItem(
              icon: Icon(Icons.air),
              title: 'Air Pollution',
              nextPage: AirPollution(),
            ),
            navItem(
              icon: Icon(Icons.sunny),
              title: 'Temperature Map',
              nextPage: TempMap(),
            ),
            navItem(
              icon: Icon(Icons.map_outlined),
              title: 'Precipitation Map',
              nextPage: WeatherMap(),
            ),
          ],
        ),
      ),
    );
  }
}

class navItem extends StatelessWidget {
  const navItem({
    super.key,
    required this.title,
    required this.icon,
    required this.nextPage,
  });

  final String title;
  final Icon icon;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            // color: Colors.black,
            height: 1,
          ),
        ),
        Material(
          color: Color.fromARGB(0, 255, 255, 255),
          child: InkWell(
              child: ListTile(
                leading: SizedBox(
                  height: 34,
                  width: 34,
                  child: icon,
                ),
                title: Text(title),
              ),
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 500));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => nextPage),
                );
              }),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.caption,
  });

  final String title, caption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // backgroundColor: Colors.blue[50],
        child: Icon(
          CupertinoIcons.cloud_snow,
          // color: Colors.indigo,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        caption,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
