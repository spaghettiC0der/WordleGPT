import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfo {
  static CollectionReference ref =
      FirebaseFirestore.instance.collection('user');
  static String id = '';
  static double score = 0.0;
  static int avatar = 0;
  static int lose = 0;
  static int recentInRow = 0;
  static int maxInRow = 0;
  static int win = 0;
  static int playedStoryMode = 0;
  static int recentRank = 0;
  static int bestRank = 0;
  static int preRank = 0;
  static int winWithoutHints = 0;
  static int isStreak = 0;
  static int winFirstAttempt = 0;

  static setData({
    String id = '@',
    double score = -1,
    int avatar = -1,
    int lose = -1,
    int recentInRow = -1,
    int maxInRow = -1,
    int win = -1,
    int playedStoryMode = -1,
    int recentRank = -1,
    int bestRank = -1,
    int preRank = -1,
    int winWithoutHints = -1,
    int isStreak = -1,
    int winFirstAttempt = -1,
  }) async {
    ProfileInfo.id = (id == '@') ? ProfileInfo.id : id;
    ProfileInfo.avatar = avatar == -1 ? ProfileInfo.avatar : avatar;
    ProfileInfo.score = score == -1 ? ProfileInfo.score : score;
    ProfileInfo.lose = lose == -1 ? ProfileInfo.lose : lose;
    ProfileInfo.recentInRow =
        recentInRow == -1 ? ProfileInfo.recentInRow : recentInRow;
    ProfileInfo.maxInRow = maxInRow == -1 ? ProfileInfo.maxInRow : maxInRow;
    ProfileInfo.win = win == -1 ? ProfileInfo.win : win;
    ProfileInfo.playedStoryMode =
        playedStoryMode == -1 ? ProfileInfo.playedStoryMode : playedStoryMode;
    ProfileInfo.recentRank =
        recentRank == -1 ? ProfileInfo.recentRank : recentRank;
    ProfileInfo.bestRank = bestRank == -1 ? ProfileInfo.bestRank : bestRank;
    ProfileInfo.preRank = preRank == -1 ? ProfileInfo.preRank : preRank;
    ProfileInfo.winWithoutHints =
        winWithoutHints == -1 ? ProfileInfo.winWithoutHints : winWithoutHints;
    ProfileInfo.isStreak = isStreak == -1 ? ProfileInfo.isStreak : isStreak;
    ProfileInfo.winFirstAttempt =
        winFirstAttempt == -1 ? ProfileInfo.winFirstAttempt : winFirstAttempt;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(ProfileInfo.id)
        .set({
      'id': ProfileInfo.id,
      'score': ProfileInfo.score,
      'avatar': ProfileInfo.avatar,
      'lose': ProfileInfo.lose,
      'recentInRow': ProfileInfo.recentInRow,
      'maxInRow': ProfileInfo.maxInRow,
      'win': ProfileInfo.win,
      'playedStoryMode': ProfileInfo.playedStoryMode,
      'recentRank': ProfileInfo.recentRank,
      'bestRank': ProfileInfo.bestRank,
      'preRank': ProfileInfo.preRank,
      'winWithoutHints': ProfileInfo.winWithoutHints,
      'isStreak': ProfileInfo.isStreak,
      'winFirstAttempt': ProfileInfo.winFirstAttempt,
    });
  }

  static getData(String userId) async {
    DocumentSnapshot data = await (FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get());
    id = data.get('id');
    score = ProfileInfo.conv(data.get('score').toString());
    avatar = data.get('avatar');
    lose = data.get('lose');
    recentInRow = data.get('recentInRow');
    maxInRow = data.get('maxInRow');
    win = data.get('win');
    playedStoryMode = data.get('playedStoryMode');
    recentRank = data.get('recentRank');
    bestRank = data.get('bestRank');
    preRank = data.get('preRank');
    winWithoutHints = data.get('winWithoutHints');
    isStreak = data.get('isStreak');
    winFirstAttempt = data.get('winFirstAttempt');
  }

  static double conv(String n) {
    if (n.contains('.')) {
      return double.parse(n);
    }
    return double.parse(n + '.0');
  }
}
