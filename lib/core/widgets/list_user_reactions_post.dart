import 'package:flutter/material.dart';

import 'app_padding_widget.dart';

class ListUserReactionsPost extends StatelessWidget {
  final List<String> users;

  const ListUserReactionsPost({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Text(users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
