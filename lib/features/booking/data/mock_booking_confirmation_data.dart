// Mock data for the Booking Confirmation screen.
// Will be replaced with Firestore data in Phase 4.

class MockBookingConfirmationData {
  MockBookingConfirmationData._();

  static const Map<String, dynamic> booking = {
    'id': 'PH-9921',
    'workerName': 'Juan Dela Cruz',
    'workerRating': 4.9,
    'workerReviews': 128,
    'isVerified': true,
    'serviceType': 'Plumbing Repair',
    'date': 'Oct 24, 2023',
    'time': '10:00 AM',
    'estimatedTotal': 850.00,
    'status': 'Waiting for worker to accept',
  };
}
