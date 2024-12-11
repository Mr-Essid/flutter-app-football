

// email validator
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  final emailRegex = RegExp(r'^[a-zA-Z][A-Za-z0-9.-]*@[a-zA-Z][a-zA-Z-]+(\.[a-zA-Z]{2,})+');
  if (!emailRegex.hasMatch(value)) {
    return "Enter a valid email address";
  }
  return null;
}


String? phoneValidator(String? value) {

  if(value == null || value.isEmpty) {
    return "Phone is required";
  }

  final regular = RegExp("[0-9]{8}");

  if(!regular.hasMatch(value)) {
    return "Please Enter A valid Number";
  }
  return null;

}


String? passwordValidator(String? value) {

  if(value == null || value.isEmpty) {
    return "Password is required";
  }


  if(value.length < 6) {
    return "Password At Least 6 Character";
  }
  return null;

}
