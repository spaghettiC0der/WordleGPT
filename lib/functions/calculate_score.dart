double calculatePoints(double score, int numberOfAttempts, bool winLose,
    String difficultyLevel, int amountOfLetters, int numberOfHintsUsed) {
  // Define the base points
  int basePoints = 100;

  // Calculate the NOA (Number of Attempts)
  double noa;
  double minAttempts = amountOfLetters / 3;
  double maxAttempts = 2 * amountOfLetters / 3;
  if (numberOfAttempts <= minAttempts) {
    noa = 1;
  } else if (numberOfAttempts <= maxAttempts) {
    noa = 0.9;
  } else {
    noa = 0.8;
  }

  // Calculate the WL (Win/Lose points)
  double wl;
  if (winLose == true) {
    wl = 1;
  } else {
    double difficultyMultiplier;
    if (difficultyLevel == 'Easy') {
      difficultyMultiplier = -0.9;
    } else if (difficultyLevel == 'Medium') {
      difficultyMultiplier = -0.8;
    } else {
      difficultyMultiplier = -0.6;
    }
    wl = difficultyMultiplier;
  }

  // Calculate the DL (Difficulty Level)
  double dl;
  if (difficultyLevel == 'Easy') {
    dl = 0.5;
  } else if (difficultyLevel == 'Medium') {
    dl = 0.7;
  } else {
    dl = 1;
  }

  // Calculate the AL (Amount of Letters)
  double al = 0.5 + (amountOfLetters - 5) * 0.1;

  // Calculate the NH (Number of Hints Used)
  double nh;
  if (numberOfHintsUsed == 0) {
    nh = 1;
  } else if (numberOfHintsUsed == 1) {
    nh = 0.8;
  } else if (numberOfHintsUsed == 2) {
    nh = 0.6;
  } else {
    nh = 0.4;
  }

  // Calculate the points
  double points = basePoints * (dl + al) * nh * wl * noa;

  // Round up the points for a win, round down for a loss
  // int roundedPoints = (winLose == 'Win') ? points.ceil() : points.floor();

  return (points / 10 + score) < 0 ? 0.0 : points / 10 + score;
}
