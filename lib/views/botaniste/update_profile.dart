import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mspr/controllers/user_controller.dart';
import 'package:mspr/models/user.dart';
import 'package:mspr/share/app_style.dart';

class BotanistUpdateProfile extends StatefulWidget {
  final User? user;
  const BotanistUpdateProfile({Key? key, this.user}) : super(key: key);

  @override
  _BotanistUpdateProfileState createState() => _BotanistUpdateProfileState();
}

class _BotanistUpdateProfileState extends State<BotanistUpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _profilePictureController = TextEditingController();

  PickedFile? _profilePictureFile; // Variable to hold the picked image file

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user?.firstName ?? '';
    _lastNameController.text = widget.user?.lastName ?? '';
    _emailController.text = widget.user?.email ?? '';
    _addressController.text = widget.user?.address ?? '';
    _cityController.text = widget.user?.city ?? '';
    _zipCodeController.text = (widget.user?.zipCode ?? '').toString();
    _passwordController.text = widget.user?.password ?? '';
    _profilePictureController.text = widget.user?.profilePicture ?? '';

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
    _profilePictureController.dispose();
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
              GestureDetector(
                onTap: () async {
                  final imagePicker = ImagePicker();
                  final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
                  setState(() {
                    _profilePictureFile = pickedFile;
                  });
                },
                child: TextFormField(
                  controller: _profilePictureController,
                  decoration: const InputDecoration(
                    labelText: 'Pick a profile picture',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppStyle.colorGreen,
                      ),
                    ),
                  ),
                  cursorColor: AppStyle.colorGreen,
                  enabled: false,
                ),
              ),


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFD7F4D0), // set the background color
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await UserController.onUpdateUser(
                      _emailController.text,
                      _passwordController,
                      _lastNameController.text,
                      _firstNameController.text,
                      _addressController.text,
                      _cityController.text,
                      _zipCodeController,
                      _profilePictureController.text,
                      true,
                    );

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Your profile has been updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Failed to update your profile. Please try again later.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
