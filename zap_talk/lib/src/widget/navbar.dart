import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Fer Andrade"), 
            accountEmail: Text("fernanda.899.andrade@gamil.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "../images/aguila.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.pushNamed(context, "/home"),
          ),
          _createDivider(),
          _createDrawerItem(
            icon: Icons.save,
            text: 'Save',
            onTap: () => Navigator.pushNamed(context, "/SavePage"),
          ),
          _createDivider(),
          _createDrawerItem(
            icon: Icons.alarm,
            text: 'Alarm',
            onTap: () => print("Alarma"),
          ),
          _createDivider(),
          _createDrawerItem(
            icon: Icons.verified_user,
            text: 'User',
            onTap: () => print("Usuario"),
          ),
          _createDivider(),
          _createDrawerItem(
            icon: Icons.local_activity,
            text: 'Location',
            onTap: () => print("Location"),
          ),
          _createDivider(),
          _createDrawerItem(
            icon: Icons.picture_as_pdf,
            text: 'Picture',
            onTap: () => print("Pintura"),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.blue),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_right, color: Colors.blue),
      onTap: onTap,
    );
  }

  Divider _createDivider() {
    return Divider(
      color: Colors.grey.shade400,
      thickness: 1.0,
      indent: 16.0,
      endIndent: 16.0,
    );
  }
}
