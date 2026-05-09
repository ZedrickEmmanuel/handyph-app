// Mock data for the Worker Dashboard screen.
// Will be replaced with Firestore data in Phase 4.

class MockWorkerDashboardData {
  MockWorkerDashboardData._();

  static const List<Map<String, dynamic>> incomingRequests = [
    {
      'initials': 'MR',
      'initialsColor': 0xFF1A3A5C,
      'name': 'Maria Reyes',
      'location': 'Quezon City (3km away)',
      'category': 'Plumbing',
      'categoryColor': 0xFF2563AC,
      'title': 'Pipe Leak Repair',
      'description':
          '"Kitchen sink pipe burst, water leaking continuously. Need someone ASAP."',
      'date': 'Oct 25, 2023',
      'time': '2:00 PM - 4:00 PM',
      'isUrgent': true,
    },
    {
      'initials': 'JS',
      'initialsColor': 0xFF4CAF50,
      'name': 'Jose Santos',
      'location': 'Makati City (8km away)',
      'category': 'Electrical',
      'categoryColor': 0xFF8B6914,
      'title': 'Ceiling Fan Installation',
      'description':
          '"Bought a new ceiling fan, need help installing it in the living room."',
      'date': 'Oct 27, 2023',
      'time': 'Morning (Flexible)',
      'isUrgent': false,
    },
  ];

  static const Map<String, dynamic> activeJob = {
    'status': 'IN PROGRESS - TODAY',
    'title': 'AC Cleaning & Freon Refill',
    'clientName': 'Anna Lim',
    'clientAddress': 'Condo Unit, BGC',
    'steps': [
      {
        'label': 'Arrived at Location',
        'subtitle': '10:15 AM',
        'status': 'completed',
      },
      {
        'label': 'Service in Progress',
        'subtitle': 'Estimated finish: 12:00 PM',
        'status': 'active',
      },
      {
        'label': 'Payment & Review',
        'subtitle': 'Pending completion',
        'status': 'pending',
      },
    ],
  };

  static const Map<String, dynamic> upcomingJob = {
    'initials': 'TOM',
    'time': '9AM',
    'title': 'TV Wall Mounting',
    'location': 'Pasig City',
  };
}
