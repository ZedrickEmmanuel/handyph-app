// Mock data for the Review Service screen.
// Will be replaced with Firestore data in Phase 4.

class MockReviewData {
  MockReviewData._();

  static const Map<String, dynamic> completedJob = {
    'workerName': 'Juan Dela Cruz',
    'workerSpecialty': 'Master Plumber',
    'isVerified': true,
    'serviceDate': 'Oct 24, 2023',
  };

  /// Rating labels based on star count
  static const Map<int, String> ratingLabels = {
    0: 'Tap to rate',
    1: 'Poor',
    2: 'Fair',
    3: 'Good',
    4: 'Great service!',
    5: 'Excellent!',
  };
}
