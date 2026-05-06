// Mock data for the Worker Profile screen.
// Will be replaced with Firestore data in Phase 4.

class MockWorkerProfileData {
  MockWorkerProfileData._();

  static const Map<String, dynamic> worker = {
    'id': 'w1',
    'name': 'Juan Dela Cruz',
    'specialty': 'Master Plumber',
    'isVerified': true,
    'rating': 4.8,
    'totalReviews': 120,
    'jobsDone': 47,
    'yearsExperience': 8,
    'skills': ['Plumbing', 'Pipe Repair', 'Installations'],
    'about':
        'Highly skilled master plumber with 8 years of experience serving the Metro Manila area. Specializing in leak detection, pipe repair, and full bathroom installations. Committed to providing clean, efficient, and long-lasting solutions for your home.',
  };

  static const List<Map<String, dynamic>> portfolio = [
    {'imageUrl': null, 'label': 'Kitchen Repair'},
    {'imageUrl': null, 'label': 'Bathroom Install'},
    {'imageUrl': null, 'label': 'Pipe Replacement'},
  ];

  static const List<Map<String, dynamic>> reviews = [
    {
      'name': 'Maria S.',
      'rating': 5,
      'comment':
          '"Juan was very professional. He fixed our leaking pipe under the sink quickly and left the area spotless. Highly recommended!"',
    },
    {
      'name': 'Carlos R.',
      'rating': 5,
      'comment':
          '"Arrived on time and explained the issue clearly before starting. The new faucet looks great."',
    },
    {
      'name': 'Ana M.',
      'rating': 4,
      'comment':
          '"Good work overall. Fixed the toilet in under an hour. Would book again."',
    },
  ];
}
