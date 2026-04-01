class ReportingService {
  static void generateWeeklyReport(String clientId) {
    // Mock logic for generating a weekly PDF/Email report
    print('Generating report for Client $clientId...');
  }

  static List<String> getPendingAlerts() {
    return [
      'John Doe achieved a new Squat PR!',
      'Jane Smith missed 2 days of nutrition logging',
      'Mike Ross reached 10k steps 7 days in a row',
    ];
  }
}
