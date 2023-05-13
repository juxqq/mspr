import 'package:flutter/material.dart';
import 'package:mspr/models/user.dart';

import '../../controllers/user_controller.dart';
import '../../share/app_style.dart';
import '../../utils/utils.dart';

class UpdateProfile extends StatefulWidget {
  final User? user;
  const UpdateProfile({Key? key, this.user}) : super(key: key);

  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user?.firstname ?? '';
    _lastNameController.text = widget.user?.lastname ?? '';
    _emailController.text = widget.user?.email ?? '';
    _addressController.text = widget.user?.address ?? '';
    _cityController.text = widget.user?.city ?? '';
    _zipCodeController.text = widget.user?.zipCode ?? '';
    _passwordController.text = widget.user?.zipCode ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black)
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFFD7F4D0),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),
                ),
                cursorColor: AppStyle.colorGreen,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern = '[a-zA-Z]';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'Enter a valid first name.';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),
                ),
                cursorColor: AppStyle.colorGreen,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern = r'^[a-zA-ZÀ-ÿ0-9\s-]+$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'Enter a valid last name.';
                    }
                  }
                  return null;                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),
                ),
                cursorColor: AppStyle.colorGreen,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern =
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'Enter a valid email address.';
                    }
                  }
                  return null;                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),
                ),
                cursorColor: AppStyle.colorGreen,
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'At least 1 capital letter, 1 number and 1 special character.';
                    }
                  }
                  return null;
                  },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),

                ),
                cursorColor: AppStyle.colorGreen,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern = r'([0-9]*) ?([a-zA-Z,\. ]*)';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'Enter a valid address.';
                    }
                  }
                  return null;
                  },
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),
                ),
                cursorColor: AppStyle.colorGreen,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern = r'([0-9]*) ?([a-zA-Z,\. ]*)';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'Enter a valid city.';
                    }
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: const InputDecoration(
                  labelText: 'Zip code',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                  ),
                ),
                cursorColor: AppStyle.colorGreen,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    String pattern = r'^((0[1-9])|([1-8][0-9])|(9[0-8])|(2A)|(2B))[0-9]{3}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value) || value.isEmpty) {
                      return 'Enter a valid zip code.';
                    }
                  }
                  return null;                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFD7F4D0), // set the background color
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showSnackBar(context, 'Updating profile...', Colors.grey);

                    UserController.updateUser(
                        _firstNameController.text,
                        _lastNameController.text,
                        _emailController.text,
                        _addressController.text,
                        _cityController.text,
                        _zipCodeController,
                        _passwordController,
                        context);
                  }
                },

                child: const Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.black)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
