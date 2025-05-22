class Progress {
  int unlockedLevel = 0;

  void updateLevel(int level) {
    if (level > unlockedLevel) {
      unlockedLevel = level;
    }
  }

  void reset() {
    unlockedLevel = 0;
  }
}