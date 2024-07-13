import 'package:flutter/material.dart';
import 'package:soccer_app/server/service/friend_request_service.dart';
import 'friend_model.dart';
import 'package:soccer_app/server/model/FriendRequest.dart';

class FriendViewModel extends ChangeNotifier {
  List<Friend> friends = [];
  List<FriendRequest> friendRequests = [];
  bool isLoading = false;

  final FriendRequestService _friendRequestService = FriendRequestService();

  Future<void> fetchFriends(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch friends logic
      final fetchedFriends = await _friendRequestService.getFriends(userId);
      friends = fetchedFriends;
    } catch (e) {
      debugPrint('Error fetching friends: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFriendRequests(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch friend requests logic
      final fetchedRequests = await _friendRequestService.getPendingRequests(userId);
      friendRequests = fetchedRequests;
    } catch (e) {
      debugPrint('Error fetching friend requests: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> acceptFriendRequest(String userId, String senderId) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _friendRequestService.acceptFriendRequest(userId, senderId);
      if (success) {
        fetchFriendRequests(userId);
        fetchFriends(userId);
      }
    } catch (e) {
      debugPrint('Error accepting friend request: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> rejectFriendRequest(String userId, String senderId) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _friendRequestService.rejectFriendRequest(userId, senderId);
      if (success) {
        fetchFriendRequests(userId);
      }
    } catch (e) {
      debugPrint('Error rejecting friend request: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}