import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

// Logged in page

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final User user = this.widget.user;

    return Scaffold(
        appBar: CustomAppBar('Home Page'),
        drawer: BuildDrawer(user),
        body: Center(child: Image.asset('assets/images/tomato.png')));
  }
}
