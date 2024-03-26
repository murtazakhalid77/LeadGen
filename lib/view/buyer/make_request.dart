import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/model/ProfanityCheckResponse.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/model/Subcategory.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/services/categoryService.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:lead_gen/model/category.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';

import 'package:lead_gen/view/conditionDropDown/conditionDropDown.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/pictureClick/imagePickerwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakeRequestPage extends StatefulWidget {
  final String categoryName;
  const MakeRequestPage(
        {Key? key, required this.categoryName})
        : super(key: key);

  @override
  State<MakeRequestPage> createState() => _MakeRequestPageState();
}

class _MakeRequestPageState extends State<MakeRequestPage> {
  String? dropdownValue;

  late CategoryService _categoryService;
  late HelperService _helperService;

  List<Categoryy> categories = [];
  List<SubCategory> subCategories = [];

  late String? locationn;
  Categoryy? category; // Initialize category variable
  late LocationModel locationModel;
  late RequestModel requestModel;
  String? phoneNumber;

String? selectedLocation; 
   late String selectedCategory;
  late final TextEditingController _title;
  late final TextEditingController _description;
  late final TextEditingController _price;

  @override
  void initState() {
    _categoryService = CategoryService();
    _helperService = HelperService();
    _title = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();

    super.initState();
    fetchCategories();
 

    dropdownValue = widget.categoryName;
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();


  }

  Future<void> fetchCategories() async {
    try {
      List<Categoryy> fetchedCategories =
          await _categoryService.fetchCategories();

      if (fetchedCategories.isNotEmpty) {
             SharedPreferences prefs = await SharedPreferences.getInstance();
                   phoneNumber = prefs.getString('phoneNumber')!;
                   // here i am also initiaizing the phone number
        setState(() {
          categories = fetchedCategories;
        });
        showCustomToast("category fetched");
      }
    } catch (error) {
      print('Error fetching categories: $error');
      showCustomToast("error while fetching category");
    }
  }

  Future<void> makeRequest(RequestModel? requestModel) async {
    try {
      RequestModel? requestModel =
          await _helperService.requestPost(this.requestModel);

      if (requestModel != null) {
        showCustomToast("Request Posted");
      }
    } catch (error) {
      print('Error fetching categories: $error');
      showCustomToast("error while posting request");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          elevation: 0.2,
          title: const Text(
            'Request',
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () {
              // Unfocus the current focus node before popping the screen
              FocusManager.instance.primaryFocus?.unfocus();
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const MyHomePage(
              //       phoneNumber: '03468288815', //TODO: to be done
              //     ), // goes to home page
              //   ),
              // ); // Add navigation functionality here
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Form(
            child: SingleChildScrollView(
                // adds scrolling in page
                child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
              right: 15,
              left: 15,
              bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              buildTextField(
                controller: _title,
                labelText: 'Title *',
                hintText: 'Enter title',
                isReadOnly: false,
                onTap: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title field cannot be empty';
                  }
                  return null;
                },
                keyboardType: null,
              ),
              const SizedBox(height: 8),
              buildTextField(
                controller: _description,
                labelText: 'Description *',
                hintText: 'Enter description',
                isReadOnly: false,
                onTap: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description field cannot be empty';
                  }
                  return null;
                },
                keyboardType: null,
              ),
              const SizedBox(height: 8),
              buildTextField(
                controller: TextEditingController(text: selectedLocation  ?? ''),
                labelText: 'Location *',
                hintText: 'Choose Location',
                isReadOnly: true,
                onTap: () async {
                  // Request permission for location
                  LocationPermission permission =
                      await Geolocator.requestPermission();

                  if (permission == LocationPermission.denied) {
                    // Handle if permission is denied
                    // You can show a message to the user informing that location permission is required.
                    return;
                  }

                  if (permission == LocationPermission.deniedForever) {
                    // Handle if permission is permanently denied
                    // You can show a message to the user informing that location permission is required and direct them to settings.
                    return;
                  }

                  // Fetch location
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  // Reverse geocoding to get address details from coordinates
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    position.latitude,
                    position.longitude,
                  );

                  Placemark placemark = placemarks.first;
                  setState(() {
                     locationModel = LocationModel(
                      administrativeArea: placemark.administrativeArea,
                      locality: placemark.locality,
                      subLocality: placemark.subLocality,
                      country: placemark.country,
                      subAdministrativeArea: placemark.subAdministrativeArea,
                      street: placemark.street);
                  });
                
                 
                  setState(() {
                    selectedLocation =
                        '${placemark.administrativeArea ?? ''} ${placemark.locality ?? ''} ${placemark.subLocality ?? ''}';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select Location';
                  }
                  return null;
                },
                keyboardType: null,
              ),
              const SizedBox(height: 8),
              buildTextField(
                controller: _price,
                labelText: 'Price',
                hintText: 'Enter the price',
                isReadOnly: false,
                onTap: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              buildDropdownWithHeading(),
              const SizedBox(height: 8),
              const Text(
                'Condition',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              const ConditionDropdown(),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  
                  RequestModel requestModel = RequestModel(
                      title: _title.text,
                      description: _description.text,
                      locationModel: locationModel.toString(),
                      category: category,
                      number: phoneNumber,
                      condition: "new",
                      createdDate: DateTime.now().toString(),
                      price: _price.text);
                  this.requestModel = requestModel;
                  await makeRequest(requestModel);
                  print(requestModel.toJson());
                    Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(18),
                  child: Center(
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ))));
  }

  Container buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isReadOnly,
    required Function()? onTap,
    required String? Function(String?)? validator,
    required TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.blueAccent.withOpacity(.3),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        onTap: onTap,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.lightBlue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.lightBlue,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.lightBlue,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Column buildDropdownWithHeading() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Category', // Heading text
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 20,
          ),
        ),
      ),
      DropdownButton<Categoryy?>(
        value: category ?? categories.firstWhereOrNull((cat) => cat.name == widget.categoryName),
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: Colors.black),
        onChanged: (Categoryy? newValue) {
          setState(() {
            category = newValue;
            dropdownValue = newValue!.name;
          });
        },
        isExpanded: true,
        hint: const Text('Select Category'),
        items: categories.map((Categoryy category) {
          return DropdownMenuItem<Categoryy>(
            value: category,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(category.name!),
            ),
          );
        }).toList(),
      ),
    ],
  );
}


  // Future<LocationModel> _fetchLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );

  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );
  //     this.selectedLocation=
  //     Placemark? currentPlace = placemarks.isNotEmpty ? placemarks[0] : null;

  //     LocationModel location = LocationModel(
  //       locality: currentPlace?.locality ?? '',
  //       subLocality: currentPlace?.subLocality ?? '',
  //       street: currentPlace?.street ?? '',
  //       country: currentPlace?.country ?? '',
  //       subAdministrativeArea: currentPlace?.subAdministrativeArea ?? '',
  //       administrativeArea: currentPlace?.administrativeArea ?? '',
  //     );

  //     return location;
  //   } catch (error) {
  //     print('Error fetching location: $error');

  //     return LocationModel();
  //   }
  // }
}

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

