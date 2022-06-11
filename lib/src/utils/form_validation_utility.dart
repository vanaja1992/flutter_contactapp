class FormValidationUtility {

  static RegExp rex =
      RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static var dtRegex = RegExp('''
/[1-9-]{4}[0-9-]{2}[0-9-]{2}/''');


 static String getFormatedDate(DateTime? birthday) {
    if(birthday==null) {
      return "";
    }
    var date =birthday.toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  static bool checkForBirthday(DateTime? birthday) {
    if(birthday== null) {
      return false;
    }
    DateTime now = DateTime.now();
    if(now.day==birthday.day && now.month==birthday.month) {
      return true;
    } else{
      return false;
    }
  }

  static String? validateName(String name) {
    name = name.trim();
    if (name.isEmpty) {
      return "Please enter a name";
    } else if (name.length < 3) {
      return "Please enter a valid name";
    } else {
      return null;
    }
  }

  static String? validateEmail(String email) {
    email = email.trim();
    if (email.isEmpty) {
      return "Please enter  a emailid";
    } else if (email.length < 8) {
      return "Please enter a valid email";
    } else if (!emailRegex.hasMatch(email)) {
      return " Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? validatePassword(String password) {
    password = password.trim();
    if (password.isEmpty) {
      return "Please enter a password";
    }
    else if(password.length< 5){
      return "Please enter a valid password";
    }
    else{
      return null;
    }
  }

  static String? validatePhone(String phone) {
    phone = phone.trim();
    if (phone.isEmpty) {
      return "Please enter a password";
    }
    else if(phone.length!= 10){
      return "Please enter a valid phone";
    }
    else{
      return null;
    }
  }

  static String? validateBirthday(String datevalue) {
    datevalue = datevalue.trim();
    if (datevalue.isEmpty) {
      return "Please enter birthdate";
    } else {
      return null;
    }
  }


}
