class SignInReqParams {
  String email;
  String password;
  SignInReqParams({required this.email, required this.password});
  Map<String, dynamic> toJson(){
    return{
      "email":email,
      "password":password
    };
  }
}