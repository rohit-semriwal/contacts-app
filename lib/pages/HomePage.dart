import 'package:contactsapp/classes/Contact.dart';
import 'package:contactsapp/classes/DBHelper.dart';
import 'package:contactsapp/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentScreen;

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
                child: ListView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
                  children: [],
                ),
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}