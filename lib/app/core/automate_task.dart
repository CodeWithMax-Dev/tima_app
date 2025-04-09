import 'package:cron/cron.dart';

class CronService {
  // Singleton instance
  static final CronService _instance = CronService._internal();

  // Factory constructor to return the singleton instance
  factory CronService() => _instance;

  // Private constructor to prevent external instantiation
  CronService._internal();

  final cron = Cron();

  void autoLocationShooterWithCron() {
    cron.schedule(Schedule.parse('*/15 * * * *'), () {

    });
    
  }

  void dispose() {
    cron.close();
  }
}
