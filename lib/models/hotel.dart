class Hotel {
  final String id, hotelName, twoPT, place, description, image;

  Hotel(
    this.id,
    this.hotelName,
    this.twoPT,
    this.place,
    this.description,
    this.image,
  );

  factory Hotel.fromMap(Map<String, dynamic> data) {
    final _id = data['id'];
    final hotelName = data['hotelname'];
    final twoPT = data['twopt'];
    final place = data['place'];
    final description = data['description'];
    final image = data['image'];

    return Hotel(_id, hotelName, twoPT, place, description, image);
  }
}

// List<Hotel> hotelList = [
//   Hotel(
//       "1",
//       "Taj Hotel",
//       "GOOD SERVICES & BREAKFAST FREE",
//       "Salem,Tamil Nadu",
//       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
//       'http://via.placeholder.com/350x150'),
//   Hotel(
//       '2',
//       "Green palace",
//       "GOOD SERVICES & BREAKFAST FREE",
//       "karur,Tamil Nadu",
//       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
//       'http://via.placeholder.com/350x150'),
//   Hotel(
//       '3',
//       "Taj Hotel",
//       "GOOD SERVICES & BREAKFAST FREE",
//       "Salem,Tamil Nadu",
//       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
//       'http://via.placeholder.com/350x150'),
//   Hotel(
//       '4',
//       "Taj Hotel",
//       "GOOD SERVICES & BREAKFAST FREE",
//       "Salem,Tamil Nadu",
//       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
//       'http://via.placeholder.com/350x150'),
//   Hotel(
//       '5',
//       "Taj Hotel",
//       "GOOD SERVICES & BREAKFAST FREE",
//       "Salem,Tamil Nadu",
//       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
//       'http://via.placeholder.com/350x150'),
// ];
