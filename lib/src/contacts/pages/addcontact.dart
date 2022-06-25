import 'package:contactapp/src/contacts/pages/mycontacts.dart';
import 'package:contactapp/src/utils/form_validation_utility.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  List<Contact> contacts = [];

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyContacts()));
              },
              icon: const Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              )),
          title: const Text(
            "Save Contact Details",
            style: TextStyle(fontSize: 23),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (!(_formKey.currentState?.validate() ?? false)) {
                    return;
                  } else {
                    ContactsService.addContact(Contact(
                        givenName: _nameController.text,
                        phones: [Item(value: _phoneController.text)],
                        emails: [Item(value: _emailController.text)],
                        birthday: getBirthday()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyContacts()));
                  }
                },
                icon: const Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.white,
                )),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                  child: Icon(
                Icons.account_circle_sharp,
                color: Colors.blueAccent,
                size: 150,
              )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (val) {
                          return FormValidationUtility.validateName(val ?? "");
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.amber, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        validator: (val) {
                          return FormValidationUtility.validatePhone(val ?? "");
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone number",
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.amber, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (val) {
                          return FormValidationUtility.validateEmail(val ?? "");
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.amber, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 19,
                      ),
                      TextFormField(
                        controller: _bdayController,
                        validator: (val) {
                          return FormValidationUtility.validateBirthday(
                              val ?? "");
                        },
                        onTap: () {
                          /// it opens a dialog to select date
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime(1990),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime.now())
                              .then((value) {
                            if (value != null) {
                              _bdayController.text = value.toIso8601String();
                            }
                          });
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: "Birthday",
                          prefixIcon: const Icon(Icons.date_range),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.amber, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }

  DateTime? getBirthday() {
    if (_bdayController.text.trim().isEmpty) return null;
    DateTime birthDayDate = DateTime.parse(_bdayController.text);
    return birthDayDate;
  }
}
