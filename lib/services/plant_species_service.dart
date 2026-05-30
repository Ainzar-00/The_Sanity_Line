import '../database/app_database.dart';
import '../data/master_plant_list.dart';
import 'dart:convert';

class PlantSpeciesWindow {
  final List<String> seenThisWeek;
  final List<String> unseenThisWeek;
  final int remainingSlots;

  PlantSpeciesWindow({
    required this.seenThisWeek,
    required this.unseenThisWeek,
    required this.remainingSlots,
  });
}

class PlantSpeciesService {
  static Future<PlantSpeciesWindow> queryWindow(
    AppDatabase db,
    String userId,
    int targetPlantSpecies,
    int progressPlantSpeciesToday,
  ) async {
    final now = DateTime.now();
    final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    
    final sixDaysAgo = now.subtract(const Duration(days: 6));
    final fromDate = '${sixDaysAgo.year}-${sixDaysAgo.month.toString().padLeft(2, '0')}-${sixDaysAgo.day.toString().padLeft(2, '0')}';

    // Get logs with meals from 6 days ago up to today
    final logsWithMeals = await db.mealLogDao.getLogsWithMeals(userId, fromDate, today);

    final Set<String> seenSpecies = {};

    for (final pair in logsWithMeals) {
      if (pair.mealLog.date == today) continue; // Exclude today from 'seen this week'
      
      final plantListStr = pair.meal.plantSpeciesList;
      if (plantListStr != null && plantListStr.isNotEmpty) {
        try {
          final List<dynamic> parsedList = jsonDecode(plantListStr);
          for (final species in parsedList) {
            seenSpecies.add(species.toString().toLowerCase());
          }
        } catch (e) {
          print('Error decoding plant species list: $e');
        }
      }
    }

    final unseenSpecies = masterPlantList.where((p) => !seenSpecies.contains(p)).toList();
    final remainingSlots = (targetPlantSpecies - progressPlantSpeciesToday).clamp(0, targetPlantSpecies);

    return PlantSpeciesWindow(
      seenThisWeek: seenSpecies.toList(),
      unseenThisWeek: unseenSpecies,
      remainingSlots: remainingSlots,
    );
  }
}
