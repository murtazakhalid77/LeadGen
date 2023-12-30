// import 'package:flutter/material.dart';
// import 'package:lead_gen/model/category.dart';
// import 'package:lead_gen/services/categoryService.dart';

// class CategoryDropDownBtn extends StatefulWidget {
//   const CategoryDropDownBtn({Key? key}) : super(key: key);

//   @override
//   State<CategoryDropDownBtn> createState() => _CategoryDropDownBtnState();
// }

// class _CategoryDropDownBtnState extends State<CategoryDropDownBtn> {
//   final CategoryService _categoryService = CategoryService();
//   String? dropdownValue;
//   List<Category> categories = []; // Store categories from API

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     try {
//       List<Category> fetchedCategories = await _categoryService.fetchCategories();

//       if (fetchedCategories.isNotEmpty) {
//         setState(() {
//           categories = fetchedCategories;
//         });
//       }
//     } catch (error) {
//       print('Error fetching categories: $error');
//       // Handle error accordingly, e.g., show an error message
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<Category>(
//       value: dropdownValue != null
//           ? categories.firstWhere((category) => category.name == dropdownValue)
//           : null,
//       icon: const Icon(Icons.arrow_drop_down),
//       style: const TextStyle(color: Colors.black),
//       onChanged: (Category? newValue) {
//         setState(() {
//           dropdownValue = newValue!.name;
//         });
//       },
//       isExpanded: true,
//       hint: const Text('Select Category'),
//       items: categories.map((Category category) {
//         return DropdownMenuItem<Category>(
//           value: category,
//           child: Text(category.name),
//         );
//       }).toList(),
//     );
//   }
// }
