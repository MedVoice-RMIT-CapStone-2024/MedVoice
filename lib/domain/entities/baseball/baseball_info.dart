class BaseballInfo {
  String mRank = "";
  String mPlayer = "";
  String mAgeThatYear = "";
  int mHits = 0;
  int mYear = 0;
  String mBats = "";
  int mId = -1;

  BaseballInfo(this.mRank, this.mPlayer, this.mAgeThatYear, this.mHits, this.mYear, this.mBats, this.mId);

  BaseballInfo.buildDefault();
}