class Agent {
  final firstName;
  final lastName;
  final phoneNumber;
  final email;
  final company;


  Agent({this.firstName, this.lastName, this.phoneNumber, this.email, this.company});

  factory Agent.fromMap(Map<String, dynamic> json) => new Agent(
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    company: json["company"],
  );

  Map<String, dynamic> toMap() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
    "company": company,
  };
}