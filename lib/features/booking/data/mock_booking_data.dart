// Mock data for the Booking Form screen.
// Will be replaced with Firestore data in Phase 4.

class MockBookingData {
  MockBookingData._();

  static const Map<String, dynamic> selectedWorker = {
    'name': 'Juan Dela Cruz',
    'specialty': 'Master Plumber',
    'isVerified': true,
    'rating': 4.9,
    'reviews': 128,
  };

  static const Map<String, dynamic> userAddress = {
    'full': '123 Mango Avenue, Barangay San Antonio, Pasig City',
  };
}
