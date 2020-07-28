import 'package:flutter/material.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'models/user.dart';
import 'package:pomodoro/styles.dart';

class AccountPage extends StatefulWidget {
  User user;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final userKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();

  var userAutoValidate = false;
  var emailAutoValidate = false;

  @override
  Widget build(BuildContext context) {
    this.widget.user = ModalRoute.of(context).settings.arguments;
    var username = this.widget.user.username;
    var email = this.widget.user.email;

    return Scaffold(
        appBar: CustomAppBar('Account Settings', widget.user),
        drawer: BuildDrawer(widget.user),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blueGrey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        smallHeader(context, 'User Name'),
                        sortaBigText(context, '$username')
                      ]
                    ),
                    Column(
                      children: [
                        smallHeader(context, 'Email'),
                        sortaBigText(context, '$email')
                      ],
                    )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FractionallySizedBox(
                  widthFactor: .6,
                  child: Form(
                    key: userKey,
                    autovalidate: userAutoValidate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLength: 10,
                            decoration: InputDecoration(
                              labelText: "New Username", 
                              border: OutlineInputBorder(),
                              counterText: ""
                            ),
                            onSaved: (value) {
                              setState(() {
                                username = value;
                              });
                              this.widget.user.changeName(value);
                              //store it
                            },
                            validator: (value) => value.isEmpty ? "Enter a new username" : null
                          ),
                        ),
                        SizedBox(width: 20),
                        RaisedButton(
                          onPressed: () {
                            if (userKey.currentState.validate()) {
                              userKey.currentState.save();
                            } else {
                              setState(() {
                                userAutoValidate = true;
                              }); 
                            }
                          },
                          child: Text('Update')
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FractionallySizedBox(
                  widthFactor: .6,
                  child: Form(
                    key: emailKey,
                    autovalidate: emailAutoValidate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLength: 30,
                              decoration: InputDecoration(
                                labelText: "New Email", 
                                border: OutlineInputBorder(),
                                counterText: ""
                              ),
                              onSaved: (value) {
                                setState(() {
                                  email = value;
                                });
                                this.widget.user.changeEmail(value);
                                //store it
                              },
                              validator: (value) => !EmailValidator.validate(value) ? "Enter a valid email" : null
                            ),
                          ),
                          SizedBox(width: 20),
                          RaisedButton(
                            onPressed: () {
                              if (emailKey.currentState.validate()) {
                                emailKey.currentState.save();
                              } else {
                                setState(() {
                                  emailAutoValidate = true;
                                }); 
                              }
                            },
                            child: Text('Update')
                          ),
                      ],
                    )
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }


}