import 'package:azlir_portfolio/views/home/home_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onColorSchemeChanged(ColorScheme colorScheme) {
    emit(state.copyWith(colorScheme: colorScheme));
  }

  void onSelectedSectionChanged(int selectedSection) {
    emit(state.copyWith(selectedSection: selectedSection));
  }

  void onSelectTag(String tag) {
    final selectedTags = [...state.selectedTags, tag];
    emit(state.copyWith(selectedTags: selectedTags));
  }

  void onUnselectTag(String tag) {
    final selectedTags = [...state.selectedTags]..remove(tag);
    emit(state.copyWith(selectedTags: selectedTags));
  }
}
