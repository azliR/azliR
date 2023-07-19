import 'package:azlir_portfolio/views/home/home_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'home_state.dart';

final homeProvider =
    NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState.initial();
  }

  void onColorSchemeChanged(ColorScheme colorScheme) {
    state = state.copyWith(colorScheme: colorScheme);
  }

  void onSelectedSectionChanged(int selectedSection) {
    state = state.copyWith(selectedSection: selectedSection);
  }

  void onSelectTag(String tag) {
    final selectedTags = [...state.selectedTags, tag];
    state = state.copyWith(selectedTags: selectedTags);
  }

  void onUnselectTag(String tag) {
    final selectedTags = [...state.selectedTags]..remove(tag);
    state = state.copyWith(selectedTags: selectedTags);
  }
}
