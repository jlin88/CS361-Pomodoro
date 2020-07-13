import 'package:flutter/material.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/components/menu.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:email_validator/email_validator.dart';
// import 'components/change_email.dart';
// import 'components/change_name.dart';

class AccountPage extends StatefulWidget {
  //User curUser = User('Test username', 'Test email', 'test password');

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User curUser = User('Test username', 'Test email', 'test password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuApp('Settings'),
        drawer: BuildDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            pageTitle(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                rowBuilder('Username: ', 'Email :', context),
                FlatButton(
                    child: Text('Change Password'),
                    onPressed: () {
                      changePassword(context);
                    }),
                FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    splashColor: Colors.redAccent,
                    child: Text('Remove Account Data'),
                    onPressed: () {
                      deleteData(context);
                    })
              ],
            )
          ],
        ));
  }

  Widget pageTitle() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Account Page',
            style: TextStyle(fontSize: 25.0, height: 2.0)));
  }

  Widget rowBuilder(String title1, String title2, BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1),
            Padding(padding: EdgeInsets.all(8)),
            Text(title2),
          ]),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(curUser.username),
            Padding(padding: EdgeInsets.all(8)),
            Text(curUser.email),
          ]),
      Column(children: [
        FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            padding: EdgeInsets.all(8.0),
            child: Text('Update'),
            onPressed: () {
              changeName(context); //, curUser);
            }),
        FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            padding: EdgeInsets.all(8.0),
            child: Text('Update'),
            onPressed: () {
              changeEmail(context); //, curUser);
            })
      ]),
    ]);
  }

  void changeName(BuildContext context) {
    final myController = TextEditingController();

    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Update Username')),
          body: Center(
              child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Please enter a new username: '),
              Expanded(
                  child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'New User Name')))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,
                padding: EdgeInsets.all(8.0),
                child: Text('Don\'t Change'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8)),
              FlatButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  padding: EdgeInsets.all(8.0),
                  child: Text('Save'),
                  onPressed: () => setState(
                        () {
                          var newUserName = myController.text;
                          if (newUserName != '') {
                            curUser.changeName(newUserName);
                            Navigator.pop(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content:
                                          Text('Username cannot be blank.'),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ]);
                                });
                          }
                        },
                      ))
            ])
          ])),
        );
      },
    ));
  }

  void changeEmail(BuildContext context) {
    final myController = TextEditingController();

    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Update Email')),
          body: Center(
              child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Please enter a new email: '),
              Expanded(
                  child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'New Email')))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,
                padding: EdgeInsets.all(8.0),
                child: Text('Don\'t Change'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8)),
              FlatButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  padding: EdgeInsets.all(8.0),
                  child: Text('Save'),
                  onPressed: () => setState(
                        () {
                          var newEmail = myController.text;
                          //assert(EmailValidator.validate(newEmail));
                          if (EmailValidator.validate(newEmail)) {
                            curUser.changeEmail(newEmail);
                            Navigator.pop(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text('Invalid Email.'),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ]);
                                });
                          }
                        },
                      ))
            ])
          ])),
        );
      },
    ));
  }

  void changePassword(BuildContext context) {
    final myController = TextEditingController();

    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Change Password')),
          // body: Center(
          //   child: FlatButton(
          //     child: Text('Click here to return'),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
          body: Center(
              child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Please enter a new password: '),
              Expanded(
                  child: TextField(
                      controller: myController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'New Password')))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                splashColor: Colors.blueAccent,
                padding: EdgeInsets.all(8.0),
                child: Text('Don\'t Change'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8)),
              FlatButton(
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  padding: EdgeInsets.all(8.0),
                  child: Text('Save'),
                  onPressed: () => setState(
                        () {
                          var newPassword = myController.text;
                          if (newPassword.length >= 6) {
                            curUser.changePwd(newPassword);
                            Navigator.pop(context);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                          'Password must be at lest 6 characters long.'),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text('Close'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ]);
                                });
                          }
                        },
                      ))
            ])
          ])),
        );
      },
    ));
  }

  void deleteData(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Remove Account Data')),
          body: Center(
            child: FlatButton(
              child: Text('Click here to return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ));
  }
}