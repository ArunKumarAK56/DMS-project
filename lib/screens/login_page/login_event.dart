import 'package:flutter/material.dart';

import '../../utils/base_equatable.dart';

abstract class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {
 BuildContext? context;
  dynamic arguments;
  
  LoginInitialEvent({this.context});

}

class LoginUserEvent extends LoginEvent {
 LoginUserEvent({this.context, this.arguments});
 BuildContext? context;
 dynamic arguments;
}


class LoginRequested extends LoginEvent {
 final String email;
 final String password;
 final String fcmToken;

 LoginRequested(this.email, this.password, this.fcmToken);

 @override
 List<Object> get props => [email, password, fcmToken];
}

class LogoutRequested extends LoginEvent {}

class ForgotPasswordRequested extends LoginEvent {
 final String email;

  ForgotPasswordRequested(this.email);

 @override
 List<Object> get props => [email];
}


