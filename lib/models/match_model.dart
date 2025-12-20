import 'team_model.dart';

class MatchModel {
  final Team home;
  final Team away;
  final String competition;

  const MatchModel({
    required this.home,
    required this.away,
    required this.competition,
  });
}
