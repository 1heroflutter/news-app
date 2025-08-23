class ApiUrl{
  static const baseUrl = 'https://0087edc3c527.ngrok-free.app/';
  //auth
  static const authBase = 'api/v1/auth/';
  static const signIn = '${authBase}signin';
  static const logout = '${authBase}logout';
  static const signUp = '${authBase}signup';
  static const signInWithGoogle = '${authBase}signinWithGoogle';
  static const sendOtp = '${authBase}sendOtp';
  static const verifyOtp = '${authBase}verifyOtp';
  static const resetPassword = '${authBase}resetPassword';
  static const authCheck = '${authBase}authCheck';

  //setupProfile-fist login
  static const userBase = 'api/v1/user/';
  static const isFirstTimeUser = '${userBase}isFirstTimeUser';
  static const setupUserProfile = '${userBase}setupUserProfile';
  static const update = '${userBase}updateUserProfile';

  //news
  static const newsBase = 'api/v1/news/';
  static const getEverything = '${newsBase}getEverything';
  static const getTrending = '${newsBase}getTrending';
  static const getByCategory = '${newsBase}getByCategory';
  static const getBySource = '${newsBase}getBySource';
  static const search = '${newsBase}search';
  static const getSources = '${newsBase}getAllSources';

}