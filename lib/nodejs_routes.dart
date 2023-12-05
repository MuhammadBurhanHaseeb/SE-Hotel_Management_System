final url = 'http://192.168.0.106:3001/'; // local host + port

final registration = url + "registration";
final login = url + 'login';
final getUserById = url + 'getUserById';

final addCredentials = url + 'createCredentials';
final getCredentialss = url + 'getCredentials';
final deleteCredentials = url + 'deleteCredentials';
final addProfilePic = url + 'addProfilePicToCredentials';
final getProfilePic = url + 'getProfilePic';
final updateCredentials = url + 'updateCredentialDocument';
final addFavToCredential = url + "addFavoritesToCredentials";
final deleteFavFromCredentials = url + 'removeFavoriteFromCredentials';
final updateUserPaymentMethodId = url + 'updateUserPaymentMethod';

final getCategories = url + 'getRoomCategories';

final getRoomsInACategory = url + 'getRoomsInCategory';
final getfacilitiesInfoById = url + 'getFacilityLookUpValuesById';
final getaroombyid = url + 'getARoomInfo';
final getReviewsOfRoom = url + 'getReviewsByRoomid';

final getBookingsOfAUser = url + 'getAllBookingsofaUser';
final createNewBooking = url + 'createBooking';

final getAllPaymentOptions = url + 'getAllPaymentOptions';
final getAllpayCardsOfUser = url + 'getAllPaymentCardsofUser';
