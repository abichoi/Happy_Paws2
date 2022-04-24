import 'package:flutter/material.dart';

class AddContactFormWidget extends StatefulWidget {
  const AddContactFormWidget({Key? key}) : super(key: key);

  @override
  State<AddContactFormWidget> createState() => _AddContactFormWidgetState();
}


class _AddContactFormWidgetState extends State<AddContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _choosen = [];
  final List<String> _data= [];
  bool _selected1 = false;
  bool _selected2 = false;
  bool _selected3 = false;
  bool _selected4 = false;
  bool _selected5 = false;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter the Name',
                labelText: 'Name'
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the name';
              }
              return null;
            },
          ),
          Container(
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0,10,0,0),
              child: Text('Category', style: TextStyle(fontSize:15, color: Colors.black54)),
            ),
          ),
          Wrap(
              spacing: 20,
              children: [
                FilterChip(
                    label: const Text('Groomer'),
                    selected: _selected1,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: _selected1 ? Colors.white : Colors.black,
                    ),
                    selectedColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                    onSelected: (bool selected1) {
                      setState(() {
                        _selected1 = !_selected1;
                        if (_selected1){
                          _choosen.add('Groomer');
                        } else {
                          _choosen.removeWhere((item) => item == 'Groomer');
                        }
                      });
                    }),
                FilterChip(
                    label: const Text('Pet Boarding'),
                    selected: _selected2,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: _selected2 ? Colors.white : Colors.black,
                    ),
                    selectedColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                    onSelected: (bool selected2) {
                      setState(() {
                        _selected2 = !_selected2;
                        if (_selected2){
                          _choosen.add('Pet Boarding');
                        } else {
                          _choosen.removeWhere((item) => item == 'Pet Boarding');
                        }
                      });
                    }),
                FilterChip(
                    label: const Text('Pet Sitter'),
                    selected: _selected3,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: _selected3 ? Colors.white : Colors.black,
                    ),
                    selectedColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                    onSelected: (bool selected3) {
                      setState(() {
                        _selected3 = !_selected3;
                        if (_selected3){
                          _choosen.add('Pet Sitter');
                        } else {
                          _choosen.removeWhere((item) => item == 'Pet Sitter');
                        }
                      });
                    }),
                FilterChip(
                    label: const Text('Vet'),
                    selected: _selected4,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: _selected4 ? Colors.white : Colors.black,
                    ),
                    selectedColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                    onSelected: (bool selected4) {
                      setState(() {
                        _selected4 = !_selected4;
                        if (_selected4){
                          _choosen.add('Vet');
                        } else {
                          _choosen.removeWhere((item) => item == 'Vet');
                        }
                      });
                    }),
                FilterChip(
                    label: const Text('Others'),
                    selected: _selected5,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: _selected5 ? Colors.white : Colors.black,
                    ),
                    selectedColor: Colors.deepPurpleAccent,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black26, width: 1),borderRadius: BorderRadius.circular(20),),
                    onSelected: (bool selected5) {
                      setState(() {
                        _selected5 = !_selected5;
                        if (_selected5){
                          _choosen.add('Others');
                        } else {
                          _choosen.removeWhere((item) => item == 'Others');
                        }
                      });
                    }),
              ]),
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter the phone number',
                labelText: 'Phone'
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the phone number';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter the address',
                labelText: 'Address'
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the address';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter the email',
                labelText: 'Email'
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the email';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                // if (_formKey.currentState!.validate()) {
                //   _ContactName.add()
                // }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class addcontactpage extends StatelessWidget{
  const addcontactpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Contact"),
          elevation: 0,
          flexibleSpace: Container(
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBC4FFF), Color(0xFF2438EA)],
              ),
            ),
          )
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: AddContactFormWidget(),
      ),
    );
  }
}