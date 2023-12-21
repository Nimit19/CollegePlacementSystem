// import 'package:flutter/material.dart';

// class AddNewTextField extends StatefulWidget {
//   final Function(List<String>) onSave;
//   const AddNewTextField({Key? key, required this.onSave}) : super(key: key);

//   @override
//   State<AddNewTextField> createState() => _AddNewTextFieldState();
// }

// class _AddNewTextFieldState extends State<AddNewTextField> {
//   List<TextEditingController> controllers = [];
//   List<String> fieldValues = [];
//   int fieldCount = 0;
//   final GlobalKey<FormState> _formAddNewFieldKey =
//       GlobalKey<FormState>(); // Add this key

//   @override
//   void initState() {
//     addTextField();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.only(
//             left: 20,
//             right: 20,
//             top: 20,
//             bottom: MediaQuery.of(context).viewInsets.bottom + 25),
//         child: Form(
//           // Wrap the content with Form widget
//           key: _formAddNewFieldKey, // Assign the form key
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               showTextFields(),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 50,
//                 width: 150,
//                 child: ElevatedButton(
//                   onPressed: addTextField,
//                   child: const Text("Add New Field"),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formAddNewFieldKey.currentState!.validate()) {
//                       // Validate the form
//                       showValues();
//                     }
//                   },
//                   child: const Text("Save"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void addTextField() {
//     if (fieldCount < 5) {
//       TextEditingController controller = TextEditingController();
//       controllers.add(controller);
//       fieldValues.add(""); // Initialize the value with an empty string

//       setState(() {
//         fieldCount++;
//       });
//     }
//   }

//   Widget showTextFields() {
//     List<Widget> textFieldRows = [];

//     for (int i = 0; i < controllers.length; i++) {
//       textFieldRows.add(buildTextFieldRow(i));
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: textFieldRows,
//     );
//   }

//   Widget buildTextFieldRow(int index) {
//     TextEditingController controller = controllers[index];

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: controller,
//                 decoration: InputDecoration(
//                   hintText: 'Enter Value ${index + 1}:',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return "Please enter a value";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   fieldValues[index] = value; // Update the fieldValues list
//                 },
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () => removeTextField(index),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         )
//       ],
//     );
//   }

//   void removeTextField(int index) {
//     if (index >= 0 && index < controllers.length) {
//       setState(() {
//         controllers.removeAt(index);
//         fieldValues.removeAt(index); // Remove the corresponding value
//         fieldCount--;
//       });
//     }
//   }

//   void showValues() {
//     // Pass the stored values to the parent widget via the onSave callback
//     widget.onSave(fieldValues);
//   }
// }

import 'package:flutter/material.dart';

class AddNewTextField extends StatefulWidget {
  final void Function(List<String> values) onSave;

  const AddNewTextField({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddNewTextFieldState createState() => _AddNewTextFieldState();
}

class _AddNewTextFieldState extends State<AddNewTextField> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> _values = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Item",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _textFieldController,
            decoration: InputDecoration(
              hintText: "Enter item",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                final value = _textFieldController.text.trim();
                if (value.isNotEmpty) {
                  setState(() {
                    _values.add(value);
                    _textFieldController.clear();
                  });
                }
              },
              child: const Text("Add"),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text(
            "Added Items:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            child: Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _values.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_values[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _values.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                widget.onSave(_values);
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
