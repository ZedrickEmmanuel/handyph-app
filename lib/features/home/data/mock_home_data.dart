// Mock data for the Home Dashboard screen.
// Will be replaced with Firestore data in Phase 4.

class MockHomeData {
  MockHomeData._();

  // ── User ──────────────────────────────────────────────
  static const Map<String, dynamic> currentUser = {
    'name': 'Maria',
    'fullName': 'Maria Santos',
    'role': 'homeowner',
    'avatarUrl': null,
  };

  // ── Upcoming Job ──────────────────────────────────────
  static const Map<String, dynamic> upcomingJob = {
    'title': 'Plumbing Service',
    'date': 'Today, 2:00 PM',
    'workerName': 'Ramon M.',
    'category': 'plumbing',
  };

  // ── Categories ────────────────────────────────────────
  static const List<Map<String, dynamic>> categories = [
    {'name': 'Plumbing', 'icon': 'plumbing'},
    {'name': 'Electrical', 'icon': 'electrical'},
    {'name': 'Painting', 'icon': 'painting'},
    {'name': 'Carpentry', 'icon': 'carpentry'},
  ];

  // ── Top Rated Pros ────────────────────────────────────
  static const List<Map<String, dynamic>> topRatedPros = [
    {
      'name': 'Juan D.',
      'title': 'Master Plumber',
      'rating': 4.9,
      'reviews': 124,
      'isVerified': true,
      'avatarUrl': null,
    },
    {
      'name': 'Marco R.',
      'title': 'Electrician',
      'rating': 4.8,
      'reviews': 98,
      'isVerified': true,
      'avatarUrl': null,
    },
    {
      'name': 'Pedro L.',
      'title': 'Painter',
      'rating': 4.7,
      'reviews': 76,
      'isVerified': false,
      'avatarUrl': null,
    },
  ];
}
