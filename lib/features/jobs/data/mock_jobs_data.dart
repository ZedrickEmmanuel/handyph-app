// Mock data for the My Jobs screen.
// Will be replaced with Firestore data in Phase 4.

class MockJobsData {
  MockJobsData._();

  static const List<Map<String, dynamic>> activeJobs = [
    {
      'id': 'j1',
      'workerName': 'Ramon D.',
      'serviceType': 'Plumbing Repair',
      'serviceIcon': 'plumbing',
      'status': 'Active',
      'dateTime': 'Oct 24, 2:00 PM',
      'location': '123 Quezon City St.',
    },
    {
      'id': 'j2',
      'workerName': 'Elena S.',
      'serviceType': 'Deep Cleaning',
      'serviceIcon': 'cleaning',
      'status': 'Active',
      'dateTime': 'Oct 25, 9:00 AM',
      'location': '123 Quezon City St.',
    },
  ];

  static const List<Map<String, dynamic>> pendingJobs = [
    {
      'id': 'j3',
      'workerName': 'Juan D.',
      'serviceType': 'Pipe Installation',
      'serviceIcon': 'plumbing',
      'status': 'Pending',
      'dateTime': 'Oct 28, 10:00 AM',
      'location': '456 Makati Ave.',
    },
    {
      'id': 'j4',
      'workerName': 'Ana R.',
      'serviceType': 'Wall Painting',
      'serviceIcon': 'painting',
      'status': 'Pending',
      'dateTime': 'Oct 30, 1:00 PM',
      'location': '789 Pasig Blvd.',
    },
  ];

  static const List<Map<String, dynamic>> completedJobs = [
    {
      'id': 'j5',
      'workerName': 'Marco T.',
      'serviceType': 'Electrical Wiring',
      'serviceIcon': 'electrical',
      'status': 'Completed',
      'dateTime': 'Oct 10, 3:00 PM',
      'location': '321 Mandaluyong St.',
    },
    {
      'id': 'j6',
      'workerName': 'Carlos M.',
      'serviceType': 'Cabinet Repair',
      'serviceIcon': 'carpentry',
      'status': 'Completed',
      'dateTime': 'Oct 5, 11:00 AM',
      'location': '654 Taguig City.',
    },
  ];
}
