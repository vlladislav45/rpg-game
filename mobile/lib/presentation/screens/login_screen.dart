import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_event.dart';
import 'package:rpg_game/logic/blocs/online/online_state.dart';
import 'package:rpg_game/utils/hex_color.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  OnlineBloc _onlineBloc;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(HexColor.convertHexColor('#31572c')),
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
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  }else if(value.length >= 15)
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
                  }else if(value.length >= 15)
                    return 'Password cannot be more than 15 symbols';
                  return null;
                },
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Your Password',
                ),
              ),
            ),
            BlocBuilder<OnlineBloc, OnlineState>(builder: (context, state) {
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
                return Column(
                  children: [
                    Text('An error occurred'),
                  ],
                );
              }
              return Column(
                children: <Widget>[
                  Text('Connected!'),
                  ElevatedButton(
                    onPressed: () {
                      _onlineBloc.add(OnlineAuthenticationEvent(
                        username: _usernameController.text.toString(),
                        password: _passwordController.text.toString(),
                      ));
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
                  Builder(builder: (context) {
                    if (state is OnlineAuthenticatedState) {
                      Navigator.of(context).pushNamed('/game');
                    } else {
                      return Text('The user is not authenticated');
                    }
                    return Container();
                  })
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}