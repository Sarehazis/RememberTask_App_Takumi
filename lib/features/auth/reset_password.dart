import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_task/features/auth/bloc/app_bloc.dart';
import 'package:re_task/features/auth/bloc/app_event.dart';
import 'package:re_task/features/auth/bloc/app_state.dart';
import 'package:re_task/features/auth/controllers/email_password.dart';

// ignore: non_constant_identifier_names
void ResetPasswordView(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 5,
                  width: 50,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reset Password',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Insert your E-mail below \nWe gonna send you a link to reset your password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Icon(
                            Icons.alternate_email,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: 250,
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: 'E-mail ID',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.amber))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      return MaterialButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          context.read<AppBloc>().add(AppEventResetPassword(
                              email: emailController.text));
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('E-mail sended'),
                              content: const Text(
                                  'An E-mail with your password recovery link was send to E-mail provided'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Ok'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Send',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
