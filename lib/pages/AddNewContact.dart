import 'package:contactsapp/classes/Contact.dart';
import 'package:contactsapp/classes/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddNewContact extends StatefulWidget {
  @override
  _AddNewContactState createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  
  // Controllers
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  var phoneController = new TextEditingController();

  // Focus Nodes
  List<FocusNode> focusNodes = [
    new FocusNode(),
    new FocusNode(),
    new FocusNode()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
            ),
            children: [

              Container(height: 20,),

              TextFormField(
                focusNode: focusNodes[0],
                onFieldSubmitted: (str) {
                  focusNodes[1].requestFocus();
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),

              TextFormField(
                focusNode: focusNodes[1],
                onFieldSubmitted: (str) {
                  focusNodes[2].requestFocus();
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),

              TextFormField(
                focusNode: focusNodes[2],
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),

              Container(height: 20,),

              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  color: Color(0xff0395eb),
                  onPressed: () async {
                    var uuid = Uuid();

                    String _id = uuid.v1();
                    String _name = nameController.text.trim();
                    String _email = emailController.text.trim();
                    String _phoneno = phoneController.text.trim();

                    DBHelper dbHelper = new DBHelper();
                    await dbHelper.openConnection();

                    Contact contact = new Contact(_id, _name, _email, _phoneno);
                    await dbHelper.addNewContact(contact).then((value) async {
                      Navigator.pop(context);
                    });

                    await dbHelper.endConnection();
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}