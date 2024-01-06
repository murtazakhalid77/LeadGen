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

import 'package:lead_gen/view/conditionDropDown/conditionDropDown.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/pictureClick/imagePickerwidget.dart';

class MakeRequestPage extends StatefulWidget {
  final String categoryName;
  const MakeRequestPage({Key? key, required this.categoryName})
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

  late LocationModel locationModel;
  late Categoryy? categoryy;
  late RequestModel requestModel;

  String? selectedLocation;
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
    _fetchLocation();

    dropdownValue=widget.categoryName;
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(
                    phoneNumber: '03468288815',   //TODO: to be done
                  ), // goes to home page
                ),
              ); // Add navigation functionality here
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
              const SizedBox(
                height: 170,
                child: ImagePickerWidget(),
              ),

              const SizedBox(height: 8),
              const Text(
                'Title *',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              //title input
              TextFormField(
                controller: _title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'title field caanot be empty';
                  }
                  return null;
                },
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
                  hintText: 'Enter title',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Description *',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'description field caanot be empty';
                  }
                  return null;
                },
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
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              //Location text
              const Text(
                'Location *',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: selectedLocation ?? ''),
                onTap: () async {
                  LocationModel location = await _fetchLocation();
                  setState(() {
                    locationModel = location;
                    selectedLocation = (location.administrativeArea! +
                        location.locality! +
                        location.subLocality!);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select Location';
                  }
                  return null;
                },
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
                  hintText: 'Choose Location',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Category',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),

              DropdownButton<Categoryy>(
                value: categories.firstOrNull,
                icon: const Icon(Icons.arrow_drop_down),
                style: const TextStyle(color: Colors.black),
                onChanged: (Categoryy? newValue) {
                  setState(() {
                    categoryy = newValue;
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
                      child: Text(category.name),
                    ),
                  );
                }).toList(),
              ),
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

              const Text(
                'Price',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              //price input
              TextFormField(
                controller: _price,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter the price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
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
                  hintText: 'Price',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // send request Button
              ElevatedButton(
                onPressed: () async {
                  RequestModel requestModel = RequestModel(
                      title: _title.text,
                      description: _description.text,
                      locationModel: locationModel,
                      category: categoryy,
                      number: "03468288815",
                      condition: "new",
                      price: _price.text);
                  this.requestModel = requestModel;
                  await makeRequest(requestModel);
                  print(requestModel.toJson());
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

  Future<LocationModel> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark? currentPlace = placemarks.isNotEmpty ? placemarks[0] : null;

      LocationModel location = LocationModel(
        locality: currentPlace?.locality ?? '',
        subLocality: currentPlace?.subLocality ?? '',
        street: currentPlace?.street ?? '',
        country: currentPlace?.country ?? '',
        subAdministrativeArea: currentPlace?.subAdministrativeArea ?? '',
        administrativeArea: currentPlace?.administrativeArea ?? '',
      );

      locationModel = location;
      return location;
    } catch (error) {
      print('Error fetching location: $error');
      // Handle the error as needed, e.g., throw a custom exception or return a default location
      return LocationModel(); // Return a default empty LocationModel or throw a custom exception
    }
  }
}
