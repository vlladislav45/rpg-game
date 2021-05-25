import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_bloc.dart';
import 'package:rpg_game/logic/blocs/online/online_event.dart';
import 'package:rpg_game/logic/blocs/online/online_state.dart';

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
      body: Column(
        children: <Widget>[
          TextField(
            controller: _usernameController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
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
                  Text('Failed to connect'),
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
                    // Navigator.of(context).pushNamed('/game');
                  },
                  child: Container(
                    child: AutoSizeText(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (state is OnlineAuthenticatedState) {
                    return Text('The user is authenticated');
                  }
                  return Text('The user is not authenticated');
                })
              ],
            );
          }),
        ],
      ),
    );
  }
}
