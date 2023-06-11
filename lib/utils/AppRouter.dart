import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lawyer_application/screens/LoginScreen.dart';
import 'package:lawyer_application/screens/RegisterScreen.dart';
import 'package:lawyer_application/screens/admin/admin_lawyers_screen.dart';
import 'package:lawyer_application/screens/appointments_client.dart';
import 'package:lawyer_application/screens/appointments_screen.dart';
import 'package:lawyer_application/screens/home_screen.dart';
import 'package:lawyer_application/screens/lawyer_details_update.dart';
import 'package:lawyer_application/screens/lawyer_register_screen.dart';
import 'package:lawyer_application/screens/profile_screen.dart';
import 'package:lawyer_application/utils/authentication.dart';

import '../screens/admin/admin_users_screen.dart';
import '../screens/lawyers_screen.dart';

class AppRouter {
  static void something() {
    print("Something app router");
  }

  

  static final router = GoRouter(initialLocation: "/login", routes: [
    GoRoute(
        path: "/login",
        builder: (context, state) {
          something();
          return LoginScreen();
        },
        redirect: (BuildContext context, GoRouterState state) {
          if (AuthenticationHelper().user != null) {
            return "/home";
          }

          return null;
        },
        routes: [
          GoRoute(
              path: "register",
              builder: (context, state) {
                return RegisterScreen();
              }),
          GoRoute(
              path: "register_lawyer",
              builder: (context, state) {
                return LaywerRegisterScreen();
              }),
        ]),
    GoRoute(
        path: "/home",
        builder: (context, state) {
          return HomeScreen();
        },
        redirect: (BuildContext context, GoRouterState state) {
          if (state.location == "/home") {
            return AuthenticationHelper().userRole != 1
                ? '/home/profile'
                : null;
          }
          return null;
        },
        routes: [
          GoRoute(
              path: "appointments",
              builder: (context, state) {
                return AppointmentsScreen();
              }),
          GoRoute(
              path: "lawyers",
              builder: (context, state) {
                return LawyersScreen();
              }),
          GoRoute(
              path: "client_appointments",
              builder: (context, state) {
                return AppointmentsClientScreen();
              }),
          GoRoute(
              path: "profile",
              builder: (context, state) {
                return ProfileScreen();
              },
              routes: [
                GoRoute(
                  path: "lawyers",
                  builder: (context, state) {
                    return AdminLawyersScreen();
                  },
                ),
                GoRoute(
                  path: "users",
                  builder: (context, state) {
                    return AdminUsersScreen();
                  },
                ),
                GoRoute(
                  path: "edit",
                  builder: (context, state) {
                    return LawyerDetailsUpdate();
                  },
                ),
              ]),
        ]),
  ]);

}
