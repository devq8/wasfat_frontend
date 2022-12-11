import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasfat_frontend/clients.dart';
import 'package:wasfat_frontend/util.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    super.key,
    required this.avatar,
    required this.username,
  });
  String avatar;
  String username;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // @override
  // void initState() {
  //   avatar = SharedPrefUtils.readPrefStr('avatar') ??
  //       'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg';
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFf9971c)),
            padding: EdgeInsets.only(
              bottom: 15,
              top: 15,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    widget.avatar,
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget.username,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              print('Go Home');
              context.go('/recipes');
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank_outlined),
            title: Text('Categories'),
            onTap: () {
              print('Go to Categories');
              context.go('/categories');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_outline),
            title: Text('Favorite'),
            onTap: () {
              print('Go Favorite');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text('Sign out'),
            onTap: () async {
              var pref = await SharedPreferences.getInstance();
              await pref.setString('token', '');
              await pref.setString('avatar', '');

              context.go('/signin');
            },
          ),
        ],
      ),
    );
  }
}
