class SignUpReqParams {
  String email;
  String password;
  SignUpReqParams({required this.email, required this.password});
  Map<String, dynamic> toJson(){
    return{
      "email":email,
      "password":password
    };
  }
}