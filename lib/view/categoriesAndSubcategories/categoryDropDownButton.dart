import 'package:flutter/material.dart';

class CategoryDropDownBtn extends StatefulWidget {
  const CategoryDropDownBtn({super.key});

  @override
  State<CategoryDropDownBtn> createState() =>
      _CategoryDropDownBtnStateState();
}

class _CategoryDropDownBtnStateState extends State<CategoryDropDownBtn> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      isExpanded: true,
      hint: const Text('Select Category'),
      items: const [
        DropdownMenuItem<String>(
          value: 'Vehicle',
          child: Text('Vehicle'),
        ),
        DropdownMenuItem<String>(
          value: 'Bikes',
          child: Text('Bikes'),
        ),
        DropdownMenuItem<String>(
          value: 'Businesses',
          child: Text('Businesses'),
        ),
        DropdownMenuItem<String>(
          value: 'Property',
          child: Text('Property'),
        ),
        DropdownMenuItem<String>(
          value: 'Mobiles',
          child: Text('Mobiles'),
        ),
        DropdownMenuItem<String>(
          value: 'Home Appliances & Electronics',
          child: Text('Home Appliances & Electronics'),
        ),
        DropdownMenuItem<String>(
          value: 'Services',
          child: Text('Services'),
        ),
        DropdownMenuItem<String>(
          value: 'Jobs',
          child: Text('Jobs'),
        ),
        DropdownMenuItem<String>(
          value: 'Furniture & Home Decore',
          child: Text('Furniture & Home Decore'),
        ),
        DropdownMenuItem<String>(
          value: 'Kids',
          child: Text('Kids'),
        ),
        DropdownMenuItem<String>(
          value: 'Fashion and Accessories',
          child: Text('Fashion and Accessories'),
        ),
        DropdownMenuItem<String>(
          value: 'Hobbies',
          child: Text('Hobbies'),
        ),
        DropdownMenuItem<String>(
          value: 'Books',
          child: Text('Books'),
        ),
        DropdownMenuItem<String>(
          value: 'Animals',
          child: Text('Animals'),
        ),
      ],
    );
  }
}
