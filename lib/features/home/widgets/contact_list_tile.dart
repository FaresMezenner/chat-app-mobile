import 'package:chat_app/shared/domaine/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactListTile extends StatelessWidget {
  final User user;
  final String lastMessageContent;
  final DateTime lastMessageSentDate;
  const ContactListTile({
    super.key,
    required this.user,
    required this.lastMessageContent,
    required this.lastMessageSentDate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(user.name,
                style: TextStyle(
                  color: user.read ? Colors.black : Colors.blue,
                  fontSize: 24,
                )),
            const SizedBox(width: 10),
            Text(
              user.phone,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lastMessageContent,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            Text(
              lastMessageSentDate.day == DateTime.now().day
                  ? "${lastMessageSentDate.hour}:${lastMessageSentDate.minute}"
                  : "${lastMessageSentDate.day}/${lastMessageSentDate.month}/${lastMessageSentDate.year}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }
}
