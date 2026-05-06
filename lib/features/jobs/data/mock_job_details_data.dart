// Mock data for the Job Details & Tracking screen.
// Will be replaced with Firestore data in Phase 4.

class MockJobDetailsData {
  MockJobDetailsData._();

  static const Map<String, dynamic> job = {
    'id': 'PH-9921',
    'status': 'Booking Accepted',
    'workerName': 'Arnel De Leon',
    'workerSpecialty': 'Aircon Cleaning Specialist',
    'workerRating': 4.9,
    'workerReviews': 128,
    'isVerified': true,
    'serviceCost': 850.00,
    'bookingFee': 0.00,
    'totalAmount': 850.00,
    'paymentMethod': 'Cash on Delivery',
    'paymentNote':
        'Payment will be made after service completion. Please prepare exact change if possible.',
    'scheduledDate': 'Sunday, Nov 24 • 10:00 AM',
    'serviceAddress':
        'Unit 402, Highrise Tower, Makati Ave, Makati City',
    'jobDescription':
        'Full cleaning for 1.5HP Split Type AC. Please check for leaks as well.',
  };

  static const List<Map<String, dynamic>> progressSteps = [
    {
      'title': 'Requested',
      'subtitle': 'Nov 24, 09:15 AM',
      'state': 'completed',
    },
    {
      'title': 'Confirmed',
      'subtitle': 'Nov 24, 10:30 AM',
      'state': 'completed',
    },
    {
      'title': 'In Progress',
      'subtitle': 'Provider is currently working',
      'state': 'active',
    },
    {
      'title': 'Completed',
      'subtitle': 'Pending final check',
      'state': 'pending',
    },
  ];
}
