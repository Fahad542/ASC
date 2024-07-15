import 'package:flutter/material.dart';

class PollItem extends StatefulWidget {

  final List<String> options;

  PollItem({ required this.options});

  @override
  _PollItemState createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            return RadioListTile<String>(
              title: Text(
                widget.options[index],
                style: TextStyle(color: Colors.white), // Assuming AppColors.whiteColor
              ),
              value: widget.options[index],
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                  print(_selectedOption);
                });
              },
              dense: true, // Makes the tiles more compact
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              activeColor: Colors.yellow, // Assuming AppColors.yellow
            );
          },
        ),
      ),
    );
  }
}



