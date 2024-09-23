abstract class EndPoints {
  const EndPoints._();
  static const String loginEndPoint = 'login';
  static const String registerEndPoint = 'register';
  static const String homeEndPoint = 'home';
  static const String categoriesEndPoint = 'categories';
  static const String favoritesEndPoint = 'favorites';
  static const String profileEndPoint = 'profile';
  static const String updateProfileEndPoint = 'update-profile';
  static const String searchEndPoint = 'products/search';
  static const String cartEndPoint = 'carts';
  static const String logOutEndPoint = 'logout';
  static const String stripeEndPoint =
      'https://api.stripe.com/v1/payment_intents';
  static const String baseUrl =
      'https://student.valuxapps.com/api/';


}
