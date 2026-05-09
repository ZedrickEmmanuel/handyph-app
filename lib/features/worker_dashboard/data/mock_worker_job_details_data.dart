// Mock data for the Worker Job Details & Tracking screen.
// Will be replaced with Firestore data in Phase 4.

class MockWorkerJobDetailsData {
  MockWorkerJobDetailsData._();

  static const Map<String, dynamic> jobDetails = {
    'jobId': '#HP-4921',
    'title': 'Pipe Leak Repair',
    'status': 'In Progress',
    'schedule': 'Today, 2:00 PM - 4:00 PM',
    'clientName': 'Maria Santos',
    'clientAddress': 'Brgy. San Lorenzo, Makati',
    'description':
        '"There is a continuous drip under the kitchen sink. I tried tightening the joint, but it seems the pipe might be cracked. Needs immediate repair."',
    'baseServiceFee': 500.00,
    'estimatedMaterials': 350.00,
    'totalAmount': 850.00,
    'paymentMethod': 'Cash Payment',
  };

  static const List<Map<String, dynamic>> progressSteps = [
    {
      'label': 'Job Accepted',
      'subtitle': 'Oct 24, 09:15 AM',
      'status': 'completed',
    },
    {
      'label': 'Arrived at Location',
      'subtitle': 'Oct 24, 01:50 PM',
      'status': 'completed',
    },
    {
      'label': 'Work in Progress',
      'subtitle': 'Started at 02:00 PM',
      'status': 'active',
    },
    {
      'label': 'Job Completed',
      'subtitle': 'Pending completion',
      'status': 'pending',
    },
  ];
}
