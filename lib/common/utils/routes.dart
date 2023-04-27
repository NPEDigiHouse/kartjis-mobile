import 'package:flutter/material.dart';

// Add some routes name here ...
const loginRoute = '/login';
const registerRoute = '/register';
const forgotPasswordRoute = '/forgot-password';
const homeRoute = '/home';

// Register the RouteObserver as a navigation observer
final routeObserver = RouteObserver<ModalRoute<void>>();
