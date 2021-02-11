import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final Function onChanged;
  final Function onSubmitted;

  const SearchBar({Key key, this.hintText, this.onChanged, this.onSubmitted}) : super(key: key);
  
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          blurRadius: 8,
          spreadRadius: 1,
          color: Colors.black.withOpacity(0.2),
        )],
      ),
      child: Row(
        children: [
          Icon(Icons.search),

          SizedBox(width: 10,),

          Flexible(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: (this.widget.hintText != null) ? this.widget.hintText : 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}