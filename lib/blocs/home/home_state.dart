part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  const HomeState({
    required this.colorScheme,
    required this.selectedSection,
    required this.selectedTags,
  });

  factory HomeState.initial() => HomeState(
        colorScheme: Section.home.getColorScheme(Brightness.dark),
        selectedSection: 0,
        selectedTags: const [],
      );

  final ColorScheme colorScheme;
  final int selectedSection;
  final List<String> selectedTags;

  HomeState copyWith({
    ColorScheme? colorScheme,
    int? selectedSection,
    List<String>? selectedTags,
  }) {
    return HomeState(
      colorScheme: colorScheme ?? this.colorScheme,
      selectedSection: selectedSection ?? this.selectedSection,
      selectedTags: selectedTags ?? this.selectedTags,
    );
  }

  @override
  List<Object?> get props => [colorScheme, selectedSection, selectedTags];
}
