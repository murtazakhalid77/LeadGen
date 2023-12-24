import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/view/buyer/Home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lead_gen/view/categoriesAndSubcategories/categoryDropDownButton.dart';
import 'package:lead_gen/view/categoriesAndSubcategories/vehicle_subCat.dart';
import 'package:lead_gen/view/conditionDropDown/conditionDropDown.dart';
import 'package:lead_gen/view/pictureClick/imagePickerwidget.dart';

class MakeRequestPage extends StatefulWidget {
  const MakeRequestPage({Key? key}) : super(key: key);

  @override
  State<MakeRequestPage> createState() => _MakeRequestPageState();
}

class _MakeRequestPageState extends State<MakeRequestPage> {
  String? dropdownValue;
  String? selectedLocation;

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
                  builder: (context) => const HomePage(), // goes to home page
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
              
              //upload Images
                const SizedBox(
              height: 170,
              child: ImagePickerWidget(),
              ),

                 const SizedBox(height: 8),

              //title text
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

              //description text
              const Text(
                'Description *',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              //description input
              TextFormField(
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
              // Location input
              TextFormField(
                readOnly: true, //prevent direct user input.
                controller: TextEditingController(text: selectedLocation ?? ''),
                onTap: () async {
                  // Fetch location and update the input field
                  //_fetchLocation that fetches the current location using the geolocator package.
                  String location = await _fetchLocation();
                  setState(() {
                    selectedLocation = location;
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

              //dropdown category text
              const Text(
                'Category',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              const CategoryDropDownBtn(),//calling categories dropdown here

              const SizedBox(height: 8),


              const SizedBox(height: 8),

              //dropdown Sub-category text
              const Text(
                'SubCategory',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              const VehicleSubCat(),//calling Sub-categories dropdown here

              const SizedBox(height: 8),


              //Condition dropdown text
              const Text(
                'Condition',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              //conditiond drop down menu
              const ConditionDropdown(),//calling condition dropdown

              const SizedBox(height: 8),


              //price text
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
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Validation passed, continue with sign-up
                    // Unfocus the current focus node before popping the screen
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            const HomePage(), // goes to all categories page
                      ),
                    );
                  }
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

  Future<String> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      return '${place.name}, ${place.locality}, ${place.administrativeArea}';
    } catch (e) {
      print('Error: $e');
      return 'Failed to fetch location';
    }
  }
}
