import 'dart:async';

import 'package:contactsapp/classes/Contact.dart';
import 'package:contactsapp/classes/DBHelper.dart';
import 'package:contactsapp/pages/AddNewContact.dart';
import 'package:contactsapp/widgets/ContactListTile.dart';
import 'package:contactsapp/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Database Connection
  DBHelper database = new DBHelper();

  int currentScreen;

  // Fetch Contacts
  bool isLoading = true;
  List contacts = new List();

  void fetchAllContacts() async {
    await database.openConnection();

    print("fetching contacts...");
    List _contacts = await database.fetchAllContacts();

    List temp = new List();
    for(int i=0; i<_contacts.length; i++) {
      String _id = _contacts[i]['id'].toString();
      String _fullname = _contacts[i]['name'].toString();
      String _email = _contacts[i]['email'].toString();
      String _phoneno = _contacts[i]['phoneno'].toString();

      Contact contact = new Contact(_id, _fullname, _email, _phoneno);
      temp.add(contact);
    }
    
    setState(() {
      if(temp.length != contacts.length) {
        print("Contacts updated!");
        contacts = temp;
      }
      isLoading = false;
    });

    await database.endConnection();
  }

  var t;

  @override
  void initState() {
    super.initState();
    fetchAllContacts();
    Timer.periodic(Duration(seconds: 1), (timer) {
      fetchAllContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [

              Container(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              SearchBar(
                hintText: 'Search for contacts',
              ),

              Expanded(
                child: (isLoading == false) ? (contacts.length > 0) ? Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: ListView(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()
                    ),
                    children: contacts.map((contact) {
                      return ContactListTile(
                        contact: contact,
                      );
                    }).toList(),
                  ),
                ) : Center(
                  child: Text('No contacts', style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20,
                  ),),
                ) : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xff0395eb)),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AddNewContact();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}