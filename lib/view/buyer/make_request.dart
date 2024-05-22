import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/model/Subcategory.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/services/categoryService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lead_gen/model/category.dart';
import 'package:lead_gen/view/conditionDropDown/conditionDropDown.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';

class MakeRequestPage extends StatefulWidget {
  final String categoryName;

  const MakeRequestPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<MakeRequestPage> createState() => _MakeRequestPageState();
}

class _MakeRequestPageState extends State<MakeRequestPage> {
  String? dropdownValue;
  bool isLoading = false;

  late CategoryService _categoryService;
  late HelperService _helperService;

  List<Categoryy> categories = [];
  List<SubCategory> subCategories = [];

  late String? locationn;
  Categoryy? category;
  late LocationModel locationModel;
  late RequestModel requestModel;
  String? email;

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
    category = categories.firstWhereOrNull((cat) => cat.name == widget.categoryName);
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
      List<Categoryy> fetchedCategories = await _categoryService.fetchCategories();

      if (fetchedCategories.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        email = prefs.getString('email')!;
        setState(() {
          categories = fetchedCategories;
          category = categories.firstWhereOrNull((cat) => cat.name == widget.categoryName);
        });
        showCustomToast("Category fetched");
      }
    } catch (error) {
      print('Error fetching categories: $error');
      showCustomToast("Error while fetching category");
    }
  }

  Future<void> makeRequest(BuildContext context, RequestModel? requestModel) async {
    try {
      setState(() {
        isLoading = true;
      });
      RequestModel? requestModel = await _helperService.requestPost(this.requestModel);

      if (requestModel != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 48),
                  SizedBox(height: 10),
                  Text("Request Posted"),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error fetching categories: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Error while posting request"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      Timer(const Duration(seconds: 7), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text(
          'Make a Request',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
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
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
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
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                  ),
                  const SizedBox(height: 10),
                  buildTextField(
                    controller: TextEditingController(text: selectedLocation ?? ''),
                    labelText: 'Location *',
                    hintText: 'Choose Location',
                    isReadOnly: true,
                    onTap: () async {
                      LocationPermission permission = await Geolocator.requestPermission();

                      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
                        return;
                      }

                      Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );

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
                          street: placemark.street,
                        );

                        selectedLocation = '${placemark.administrativeArea ?? ''} ${placemark.locality ?? ''} ${placemark.subLocality ?? ''}';
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  buildDropdownWithHeading(),
                  const SizedBox(height: 15),
                  const Text(
                    'Condition',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  const ConditionDropdown(),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        RequestModel requestModel = RequestModel(
                          id: 0,
                          title: _title.text,
                          description: _description.text,
                          locationModel: locationModel.toString(),
                          category: category,
                          email: email,
                          condition: "new",
                          acceptedSeller: null,
                          accepted: "",
                          acceptedAmount: 0,
                          createdDate: DateTime.now().toString(),
                          status: false,
                          price: _price.text,
                        );
                        this.requestModel = requestModel;
                        await makeRequest(context, requestModel);
                        print(requestModel.toJson());
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Center(
                      child: Text(
                        'Send',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.grey.withOpacity(0.6),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              ),
            ),
        ],
      ),
    );
  }

  Container buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isReadOnly,
    required Function()? onTap,
    required String? Function(String?)? validator,
    required TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        onTap: onTap,
        validator: validator,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
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
            style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Categoryy?>(
              value: category,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              style: const TextStyle(color: Colors.black),
              dropdownColor: Colors.white,
              onChanged: (Categoryy? newValue) {
                setState(() {
                  category = newValue;
                  dropdownValue = newValue!.name;
                });
              },
              isExpanded: true,
              hint: const Text('Select Category', style: TextStyle(color: Colors.black)),
              items: categories.map((Categoryy category) {
                return DropdownMenuItem<Categoryy>(
                  value: category,
                  child: Text(category.name!, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
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
