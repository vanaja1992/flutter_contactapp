import '../utils/form_validation_utility.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import '../utils/launcher_utility.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;

  const ContactDetails({required this.contact, Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  String phone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: widget.contact.avatar != null,
              replacement: Container(
                  height: 100,
                  width: 100,
                  color: Colors.blueGrey,
                  child: const Icon(Icons.person)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: MemoryImage(widget.contact.avatar!))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.contact.displayName}",
                  style: const TextStyle(
                      fontSize: 29,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.green,
              ),
              title: Visibility(
                  visible: widget.contact.phones != null,
                  replacement: const Text("Phone number not added yet"),
                  child: Text(
                      widget.contact.phones
                              ?.map((e) => e.value)
                              .toSet()
                              .join(", ") ??
                          "",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: Colors.red.shade300,
              ),
              title: Visibility(
                  visible: widget.contact.emails != null,
                  replacement: const Text("Email not added yet"),
                  child: Text(
                      widget.contact.emails
                              ?.map((e) => e.value)
                              .toSet()
                              .join(",") ??
                          "",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal))),
            ),
            ListTile(
              leading: Icon(
                Icons.cake,
                color: Colors.pinkAccent.shade200,
              ),
              title: Visibility(
                  visible: widget.contact.birthday != null,
                  replacement: const Text("Birthday not added yet"),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            FormValidationUtility.getFormatedDate(
                                widget.contact.birthday),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: widget.contact.birthday != null,
              child: Visibility(
                  visible: !FormValidationUtility.checkForBirthday(
                      widget.contact.birthday),
                  replacement: ListTile(
                    leading:
                        const Icon(Icons.cake, size: 20, color: Colors.teal),
                    title: Text(
                        "Today is  ${widget.contact.displayName} 's birthday.\nSend a warm Greetings!!",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic)),
                    trailing: IconButton(
                        onPressed: () {
                          smsContact();
                        },
                        icon: const Icon(
                          Icons.message,
                          size: 23,
                          color: Colors.pinkAccent,
                        )),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text(
                        "${getBirthDateCount()} more days to wish ${widget.contact.displayName}'s birthday",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic)),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 29,
                      ),
                    ),
                    onTap: () {
                      callContact();
                    }),
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                      child: const Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 29,
                      ),
                    ),
                    onTap: () {
                      smsContact();
                    }),
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red.shade300),
                      child: const Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 29,
                      ),
                    ),
                    onTap: () {
                      emailContact();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void callContact() {
    if (widget.contact.phones == null) {
      return;
    } else if (widget.contact.phones!.isEmpty) {
    } else if (widget.contact.phones?.length == 1) {
      LauncherUtility.makeCall(
          "${widget.contact.phones!.first.value}"); // phones! = not null
    } else {
      showPhoneSelectorDialog(widget.contact.phones!);
    }
  }

  void smsContact() {
    if (widget.contact.phones == null) {
      return;
    } else if (widget.contact.phones!.isEmpty) {
    } else if (widget.contact.phones?.length == 1) {
      LauncherUtility.sendSms(
          "${widget.contact.phones!.first.value}"); // phones! = not null
    } else {
      showSmsSelectorDialog(widget.contact.phones!);
    }
  }

  void emailContact() {
    if (widget.contact.emails == null) {
      return;
    } else if (widget.contact.emails!.isEmpty) {
    } else if (widget.contact.emails?.length == 1) {
      LauncherUtility.sendEmail(
          "${widget.contact.emails!.first.value}"); // phones! = not null
    } else {
      showEmailSelectorDialog(widget.contact.emails!);
    }
  }

  String getBirthDateCount() {
    if (widget.contact.birthday == null) return "";
    DateTime now = DateTime.now();
    DateTime currentYearBday = DateTime(
        now.year, widget.contact.birthday!.month, widget.contact.birthday!.day);
    if (currentYearBday.isBefore(now)) {
      currentYearBday = DateTime(now.year + 1, widget.contact.birthday!.month,
          widget.contact.birthday!.day);
    }
    var differenceDate = currentYearBday.difference(now).inDays;
    return differenceDate.toString();
  }

  void showPhoneSelectorDialog(List<Item> phones) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the number"),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle),
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: phones.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.makeCall("${phones[pos].value}");
                        },
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.green,
                          size: 23,
                        ),
                        title: Text("${phones[pos].value}"));
                  }),
            ),
          );
        });
  }

  void showSmsSelectorDialog(List<Item> phones) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the number"),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle),
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: phones.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.sendSms("${phones[pos].value}");
                        },
                        leading: const Icon(
                          Icons.message,
                          color: Colors.blue,
                          size: 23,
                        ),
                        title: Text("${phones[pos].value}"));
                  }),
            ),
          );
        });
  }

  void showEmailSelectorDialog(List<Item> email) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose the mailid"),
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  shape: BoxShape.rectangle),
              height: 100,
              width: 200,
              child: ListView.builder(
                  itemCount: email.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pos) {
                    return ListTile(
                        onTap: () {
                          LauncherUtility.sendEmail("${email[pos].value}");
                        },
                        leading: Icon(
                          Icons.email,
                          color: Colors.red.shade300,
                          size: 23,
                        ),
                        title: Text("${email[pos].value}"));
                  }),
            ),
          );
        });
  }
}
