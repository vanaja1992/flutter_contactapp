import 'package:contactapp/src/contacts/pages/addcontact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import '../../utils/launcher_utility.dart';
import 'contactdetails.dart';

class MyContacts extends StatefulWidget {
  const MyContacts({Key? key}) : super(key: key);

  @override
  _MyContactsState createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  List<Contact> contacts = [];
  List<Contact> filteredData = [];
  bool isLoading = true;
  String phone = "";
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPermission();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.person,
          size: 40,
          color: Colors.white,
        ),
        title: const Text(
          "All Contacts",
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(
              Icons.add,
              size: 35,
            ),
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddContact()))
                  .then((value) => getData());
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Enter the name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  // icon is 48px widget),
                  onChanged: (value) {
                    searchByKeyword(value);
                  },
                ),
              ),
              SizedBox(
                height: 660,
                child: Expanded(
                  child: Visibility(
                    visible: !isLoading,
                    replacement:
                        const Center(child: CupertinoActivityIndicator()),
                    child: Visibility(
                      visible: contacts.isNotEmpty,
                      replacement: const Center(
                          child: Text(
                        "There is no contact to view",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      child: Visibility(
                        visible: filteredData.isNotEmpty,
                        replacement: const Text(""),
                        child: ListView.separated(
                            separatorBuilder: (context, pos) {
                              return const Divider(
                                height: 5,
                              );
                            },
                            itemCount: filteredData.length,
                            itemBuilder: (context, pos) {
                              Contact itemcontact = filteredData[pos];

                              if (itemcontact.phones != null) {
                                phone = itemcontact.phones
                                        ?.map((e) => e.value)
                                        .toSet()
                                        .join(",") ??
                                    "";
                              }
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactDetails(
                                                contact: itemcontact,
                                              )));
                                },

                                leading: CircleAvatar(
                                  radius: 20,
                                  child: Visibility(
                                      visible: itemcontact.avatar != null || ((itemcontact.avatar?.length??0)>0),
                                      replacement: const Icon(Icons.person),
                                      child: CircleAvatar(
                                          backgroundImage: MemoryImage(
                                              itemcontact.avatar!))),
                                          // backgroundImage: MemoryImage(
                                          //     itemcontact.avatar!))),
                                ),
                                title: Text(
                                    filteredData[pos].displayName ?? "Null"),
                                //subtitle: Text("${phone}"),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setPermission() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
// Get all contacts on device
      getData();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void callContact(Contact itemcontact) {
    if (itemcontact.phones == null) {
      return;
    } else if (itemcontact.phones!.isEmpty) {
      return;
    } else if (itemcontact.phones?.length == 1) {
      LauncherUtility.makeCall(
          "${itemcontact.phones!.first.value}"); // phones! = not null
    } else {
      showPhoneSelectorDialog(itemcontact.phones!);
    }
  }

  void showPhoneSelectorDialog(List<Item> phones) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the number"),
            content: SizedBox(
              height: 500,
              width: 500,
              child: ListView.builder(
                  itemCount: phones.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.makeCall("${phones[pos].value}");
                        },
                        title: Text("${phones[pos].value}"));
                  }),
            ),
          );
        });
  }

  Future<void> getData() async {
    List<Contact> contactTemp = await ContactsService.getContacts();
    setState(() {
      contacts = contactTemp;
      filteredData = contactTemp;
      isLoading = false;
    });
  }

  void searchByKeyword(String value) {
    if (value.isEmpty) {
      setState(() {
        filteredData = contacts;
      });
    } else {
      setState(() {
        filteredData = contacts
            .where((search) => {search.givenName?.toUpperCase() ?? ""}
                .contains(value.toUpperCase()))
            .toList();
      });
    }
  }
}
