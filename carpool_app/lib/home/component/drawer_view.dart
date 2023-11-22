import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('Номин Даваа'),
            accountEmail: Text('nomin@email.com'),
            currentAccountPicture: CircleAvatar(
              ///
              backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_user.png'),
            ),
            title: const Text('Таны бүртгэл'),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_complain.png'),
            ),
            title: const Text('Гомдол гаргах'),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_vector.png'),
            ),
            title: const Text('Аялалын түүх'),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_aboutUs.png'),
            ),
            title: const Text('Бидний тухай'),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_settings.png'),
            ),
            title: const Text('Тохиргоо'),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_help.png'),
            ),
            title: const Text('Тусламж'),
            onTap: () {},
          ),
          ListTile(
            leading: SizedBox(
              height: 10,
              child: Image.asset('assets/icons/ic_logout.png'),
            ),
            title: const Text('Системээс гарах'),
            onTap: () {},
          ),
        ]),
      ),
    );
  }
}
