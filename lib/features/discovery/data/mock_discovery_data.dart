// Mock data for the Discovery screen.
// Will be replaced with Firestore data in Phase 4.

class MockDiscoveryData {
  MockDiscoveryData._();

  // ── Workers ───────────────────────────────────────────
  static const List<Map<String, dynamic>> workers = [
    {
      'id': 'w1',
      'name': 'Ramon Dela Cruz',
      'specialty': 'Plumber',
      'isVerified': true,
      'rating': 4.8,
      'reviews': 124,
      'successRate': 92,
      'baseRate': 500,
      'isFavorite': false,
    },
    {
      'id': 'w2',
      'name': 'Maria Santos',
      'specialty': 'Cleaner',
      'isVerified': true,
      'rating': 4.9,
      'reviews': 89,
      'successRate': 98,
      'baseRate': 400,
      'isFavorite': false,
    },
    {
      'id': 'w3',
      'name': 'Jose Garcia',
      'specialty': 'Electrician',
      'isVerified': true,
      'rating': 4.7,
      'reviews': 210,
      'successRate': 95,
      'baseRate': 600,
      'isFavorite': false,
    },
    {
      'id': 'w4',
      'name': 'Ana Reyes',
      'specialty': 'Painter',
      'isVerified': false,
      'rating': 4.5,
      'reviews': 56,
      'successRate': 88,
      'baseRate': 450,
      'isFavorite': false,
    },
    {
      'id': 'w5',
      'name': 'Carlos Mendoza',
      'specialty': 'Carpenter',
      'isVerified': true,
      'rating': 4.6,
      'reviews': 73,
      'successRate': 91,
      'baseRate': 550,
      'isFavorite': false,
    },
  ];

  // ── Filter Options ────────────────────────────────────
  static const List<String> filterChips = [
    'Rating 4+',
    'Verified Only',
  ];
}
