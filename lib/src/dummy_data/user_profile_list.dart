// dummy_data.dart

import 'package:restaurant_app/src/model/profile/user_profile_model.dart';

List<UserProfile> dummyProfiles = [
  UserProfile(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaBMQCheSquzvr2YMLKVuD4SHaVYtwMZf4IQ&s",
      name: "John Doe",
      id: "john_doe_123",
      email: "john_doe@example.com",
      phone: "32432",
      bio: ''),
  UserProfile(
      imageUrl: "https://example.com/images/jane_doe.png",
      name: "Jane Doe",
      id: "jane_doe_456",
      email: "jane_doe@example.com",
      phone: "32432",
      bio: ''),
  UserProfile(
      imageUrl: "https://example.com/images/james_smith.png",
      name: "James Smith",
      id: "james_smith_789",
      email: "james_smith@example.com",
      phone: "32432",
      bio: ''),
];
