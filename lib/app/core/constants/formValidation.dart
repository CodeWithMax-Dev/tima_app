class form_validation {
  // !phone number validation
  String? validatephonenumber(String value) {
    RegExp regex = RegExp(r'^[6-9][0-9]{9}$');
    if (value.isEmpty) {
      return 'Please Enter Your Phone Number';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid Contact No';
    } else if (value.length != 10) {
      return 'Phone Number is not valid';
    }
    return null; // Return null if the phone number is valid
  }

  // !phone number validation
  static bool validatePhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(phoneNumber);
  }

  // !validateSpecialphonenumber validation
  static String validateSpecialphonenumber(value) {
    if (value.isEmpty) {
      return 'Please Enter Your Phone Number';
    } else {
      return value; //changes
    }
  }

  // !validate name
  static String validatename(value) {
    if (value.isEmpty) {
      return 'Please Enter Your Name';
    }
    return value; //changes
  }

  // !validate email
   String validateEmail(value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex =  RegExp(pattern);
    if (!regex.hasMatch(value) || value == null) {
      return 'Please Enter a Valid Email address ';
    } else {
      return '';
    }
  }
  // !validate pettern
  static bool validateEmailtruefalse(value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value) || value == null) {
      return false;
    } else {
      return true;
    }
  }

  // !validate password
  static String validatepassword(value) {
    if (value.isEmpty) {
      return 'Please Enter Password';
    } else if (value.length < 6) {
      return 'Password Must Be Greater Than Equals to 6 Digit';
    }
    return value; //changes
  }

  // !validate new password

  static String validatenewpassword(value) {
    if (value.isEmpty) {
      return 'Please Enter New Password';
    } else if (value.length < 6) {
      return 'Password Length Must Be Greater Than Equals to 8 Digit';
    }
    return value; //changes
  }

  // !validate old password
  static String validateoldpassword(value) {
    if (value.isEmpty) {
      return 'Please Enter Old Password';
    } else if (value.length < 8) {
      return 'Password Length Must Be Greater Than Equals to 8 Digit';
    }
    return value; //changes
  }

  // !validate c password
  static String validatecpassword(value) {
    if (value.isEmpty) {
      return 'Please Enter Confirm Password';
    } else if (validatepassword != validatecpassword) {
      return 'Confirm Password Must be Same As Password';
    }
    return value; //changes
  }

  // !validate first name
  static String validatefirstname(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate last name
  static String validatelastname(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate middle name
  static String validatemiddlename(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate address
  static String validateaddress(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate countery name
  static String validatecountry(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate state
  static String validatestate(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate city
  static String validatecity(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }

  // !validate pincode
  static String validatepincode(value) {
    if (value.isEmpty) {
      return 'Please Enter a Valid Name';
    }
    return value; //changes
  }
}
