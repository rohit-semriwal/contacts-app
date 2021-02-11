import 'package:contactsapp/classes/Contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListTile extends StatelessWidget {
  final Contact contact;

  const ContactListTile({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(this.contact.phoneno),
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: ListTile(
        onTap: () async {
          await FlutterPhoneDirectCaller.callNumber(this.contact.phoneno);
        },
        leading: CircleAvatar(
          child: Text(this.contact.fullname[0]),
        ),
        title: Text(this.contact.fullname),
        subtitle: Text(this.contact.phoneno),
      ),
    );
  }
}