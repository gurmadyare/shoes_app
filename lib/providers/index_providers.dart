import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageViewIndexProvider = StateProvider<int>((ref) => 0);
final cardIndexProvider = StateProvider<int>((ref) => 0);
final tabsIndexProvider = StateProvider<int>((ref) => 0);
final currentBottomIndexProvider = StateProvider<int>((ref) => 0);
final shoeImageIndexProvider = StateProvider<int>((ref) => 0);
final selectedSizeIndexProvider = StateProvider((ref) => 0);
final selectedSizeStandard = StateProvider((ref) => 0);
