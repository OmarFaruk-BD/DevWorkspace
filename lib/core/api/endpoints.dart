class Endpoints {
  Endpoints._();

  ///BASEURL
  // static const String baseURL = 'https://desieventsgo.com';
  // static const String fileURL = 'https://static.desieventsgo.com/uploads';

  ///STAGINGURL
  static const String baseURL = 'http://desieventgoapi.gdnserver.com';
  static const String fileURL =
      'https://desievent-staging-gisl.s3.us-east-1.amazonaws.com';

  ///AUTH
  static const String memberSignin = '/api/members/signin';
  static const String memberSignup = '/api/members/signup';
  static const String memberDelete = '/api/members/delete/';
  static const String googleSignin = '/api/members/google/signin';
  static const String resetPassword = '/api/members/reset-password';
  static const String forgetPassword = '/api/members/forgot-password';
  static const String changePassword = '/api/members/change-password';

  ///MEMBER
  static const String members = '/api/members';
  static const String settings = '/api/members/settings';
  static const String memberProfile = '/api/members/profile';
  static const String memberDashboard = '/api/member-dashboard';
  static const String scannerAccess = '/api/event-members/update';

  ///HOME
  static const String home = '/api/home';
  static const String adSponsor = '/api/ad-sponsors';

  ///EVENT
  static const String event = '/api/events';
  static const String eventCreate = '/api/events/create-member';
  static const String eventUpdate = '/api/events/update-member';
  static const String eventStatusUpdate = '/api/events/update-status';
  static const String eventRequestAccess = '/api/event-members/request';
  static const String additionalUpdate = '/api/events/aditional-info-member';
  static const String grandSponsorUpdate = '/api/events/update-grand-sponsors';
  static const String ticketUpdate = '/api/events/update-ticket';
  static const String sponsorshipUpdate = '/api/events/update-sponsorships';
  static const String vendorshipUpdate = '/api/events/update-vendorships';
  static const String couponUpdate = '/api/events/update-coupon';
  static const String organizerUpdate = '/api/events/update-organizers';
  static const String organizationUpdate =
      '/api/events/organization-info-member';

  ///FILTER
  static const String country = '/api/countries';
  static const String location = '/api/locations';
  static const String culture = '/api/cultures';
  static const String category = '/api/categories';

  ///ORDER
  static const String order = '/api/orders';
  static const String orderDelete = '/api/orders/delete';
  static const String session = '/api/checkout-sessions';

  ///CHECKOUT
  static const String buyTicket = '/api/tickets/buy';
  static const String checkout = '/api/checkout_sessions';
  static const String paymentIntent = '/api/checkout/create-payment-intent';

  ///TICKET
  static const String tickets = '/api/tickets';
  static const String ticketEdit = '/api/tickets/update';
  static const String reservation = '/api/tickets/reservations';
  static const String reservationDetail = '/api/tickets/reservations-details';
  static const String checkScanPermission =
      '/api/tickets/check-scan-permission';
  static const String updateScanStatus =
      '/api/tickets/update-reservation-item-status';

  ///COUPON
  static const String coupon = '/api/coupons';
  static const String eventCoupon = '/api/events/coupon';
  static const String couponEdit = '/api/coupons/update';

  ///NEWS&FEATURE
  static const String news = '/api/news';
  static const String feature = '/api/features';

  ///GRANDSPONSOR
  static const String grandSponsor = '/api/grand-sponsors';

  ///SPONSORSHIP
  static const String sponsorship = '/api/sponsorships';
  static const String sponsorshiplist = '/api/sponsorships/member';
  static const String sponsorshipEdit = '/api/sponsorships/update';
  static const String sponsorshipCheckout = '/api/sponsors/checkout';

  ///SPONSOR
  static const String sponsor = '/api/sponsors';
  static const String createSponsor = '/api/sponsors/create';
  static const String editSponsor = '/api/sponsors/update';
  static const String eventSponsors = '/api/events/sponsors';
  static const String sponsorApprove =
      '/api/member-dashboard/update-sponsor-status';

  ///VENDORSHIP
  static const String vendorship = '/api/vendorships';
  static const String vendorshiplist = '/api/vendorships/member';
  static const String vendorshipEdit = '/api/vendorships/update';
  static const String vendorshipCheckout = '/api/vendors/checkout';

  ///VENDOR
  static const String vendor = '/api/vendors';
  static const String editVendor = '/api/vendors/update';
  static const String createVendor = '/api/vendors/create';
  static const String eventVendors = '/api/events/vendors';
  static const String vendorApprove =
      '/api/member-dashboard/update-vendor-status';

  ///ORGANIZATION
  static const String organization = '/api/organizations';

  ///ORGANIZER
  static const String organizer = '/api/organizers';
  static const String reOrder = '/api/events/update-organizers-ordering';

  ///ABOUTUS
  static const String aboutUs = '/api/pages';
  static const String contactUs = '/api/contacts/create';
}
