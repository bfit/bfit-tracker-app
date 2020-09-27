import 'package:bfit_tracker/models/coval_user.dart';
import 'package:bfit_tracker/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoRepository {
  final _userInfoCollection = FirebaseFirestore.instance.collection('UserInfo');

  Stream<UserInfo> retrieve(CovalUser user) {
    return _userInfoCollection
        .document(user.getUid())
        .snapshots()
        .map(UserInfo().fromSnapshot);
  }

  Future<void> create(CovalUser user, UserInfo userInfo) async {
    return await _userInfoCollection
        .document(user.getUid())
        .setData(userInfo.toDocument());
  }

  Future<void> update(CovalUser user, UserInfo userInfo) async {
    return await _userInfoCollection
        .document(user.getUid())
        .updateData(userInfo.toDocument());
  }
}
