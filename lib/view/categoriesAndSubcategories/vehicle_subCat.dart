import 'package:flutter/material.dart';

class VehicleSubCat extends StatefulWidget {
  const VehicleSubCat({super.key});

  @override
  State<VehicleSubCat> createState() => _VehicleSubCatState();
}

class _VehicleSubCatState extends State<VehicleSubCat> {
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
      hint: const Text('Select Sub-Category'),
      items: const [
        DropdownMenuItem<String>(
          value: 'Cars',
          child: Text('Cars'),
        ),
        DropdownMenuItem<String>(
          value: 'Cars Accessories',
          child: Text('Car Accessories'),
        ),
        DropdownMenuItem<String>(
          value: 'Spare Parts',
          child: Text('Spare Parts'),
        ),
        DropdownMenuItem<String>(
          value: 'Buses, Vans & Trucks',
          child: Text('Buses, Vans & Trucks'),
        ),
        DropdownMenuItem<String>(
          value: 'Rikshaw & Chingchi',
          child: Text('Rikshaw & Chingchi'),
        ),
        DropdownMenuItem<String>(
          value: 'Tractors & Trailers',
          child: Text('Tractors & Trailers'),
        ),
        DropdownMenuItem<String>(
          value: 'Cars on Installments',
          child: Text('Cars on Installments'),
        ),
        DropdownMenuItem<String>(
          value: 'Boats',
          child: Text('Boats'),
        ),
        DropdownMenuItem<String>(
          value: 'Other Vehicles',
          child: Text('Other Vehicles'),
        ),
       
      ],
    );
  }
}