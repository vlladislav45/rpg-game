import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/bloc/online/online_bloc.dart';
import 'package:rpg_game/logic/bloc/online/online_event.dart';
import 'package:rpg_game/logic/bloc/online/online_state.dart';
import 'package:rpg_game/util/hex_color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late OnlineBloc _onlineBloc;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _onlineBloc = BlocProvider.of<OnlineBloc>(context);
    _onlineBloc.add(OnlineConnectEvent());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _loginButton(BuildContext context, String message) {
    return Column(
      children: <Widget>[
        message != '' ? Text('$message') : Container(),
        ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {

              _onlineBloc.add(OnlineAuthenticationEvent(
                username: _usernameController.text.toString(),
                password: _passwordController.text.toString(),
              ));
            }
          },
          child: Container(
            child: AutoSizeText(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.width / 16,
            alignment: Alignment.center,
          ),
        ),
        Text('Connected to Main Server!'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Color(HexColor.convertHexColor('#31572c')),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(right: 15, top: 15),
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/login/exit.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    onTap: () {
                      exit(0);
                    },
                  ),
                ],
              ),
              Container(
                child: AutoSizeText(
                  'Welcome to \n Daily Wars',
                  minFontSize: 15,
                  maxFontSize: 25,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username cannot be empty';
                          } else if (value.length >= 15)
                            return 'Username cannot be more than 15 symbols';
                          return null;
                        },
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your Username',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          } else if (value.length >= 15)
                            return 'Password cannot be more than 15 symbols';
                          return null;
                        },
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your Password',
                        ),
                        onFieldSubmitted: (value) {
                          //If enter is pressed after user is entered his password AND
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _onlineBloc.add(OnlineAuthenticationEvent(
                              username: _usernameController.text.toString(),
                              password: _passwordController.text.toString(),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<OnlineBloc, OnlineState>(
                  listener: (context, state) {
                if (state is OnlineAuthenticatedState) {
                  Navigator.of(context).pushNamed('/game');
                }

                if(state is OnlineDisconnectedState) {
                  Navigator.of(context).pushNamed('/');
                }
              },
                builder: (context, state) {
                    print(state);
                    if (state is OnlineInitialState) {
                      return Container();
                    }
                    if (state is OnlineConnectingState) {
                      return CircularProgressIndicator();
                    }
                    if (state is OnlineConnectErrorState) {
                      return Column(
                        children: [
                          Text('No internet connection, try again later..'),
                        ],
                      );
                    }
                    if (state is OnlineConnectTimeoutState) {
                      return Column(
                        children: [
                          Text('Connection timed out'),
                        ],
                      );
                    }
                    if (state is OnlineDisconnectedState) {
                      return Column(
                        children: [
                          Text('Disconnected'),
                        ],
                      );
                    }
                    if (state is OnlineErrorState) {
                      return _loginButton(context, '${state.error}');
                    }
                    return _loginButton(context, '');
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
