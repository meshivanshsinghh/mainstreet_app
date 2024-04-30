class SquareAPIUrls {
  static const baseUrl = 'https://connect.squareup.com';
  static const getUserToken = '$baseUrl/oauth2/token';
  static const getMerchantData = '$baseUrl/v2/merchants';
}

class Constants {
  static const clientSecret =
      'sq0csp-4I5SVth5kV-VTddJWlyxTvrdAcKXzyGJAB0O3glZN20';
  static const clientId = 'sq0idp-2fQOp6SD7KXTB2iTH50wkw';
  static const authRedirectUrl =
      'https://backslashflutter.github.io/square_redirect_page';

  static const authScope = [
    'MERCHANT_PROFILE_READ',
    'CUSTOMER_READ',
    'CUSTOMER_WRITE',
    'ITEMS_READ',
    'ITEMS_WRITE',
    'ORDERS_READ',
    'ORDERS_WRITE',
    'PAYMENTS_READ',
    'PAYMENTS_WRITE',
    'INVOICES_READ',
    'INVOICES_WRITE',
  ];
}
