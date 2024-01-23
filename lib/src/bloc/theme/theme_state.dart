part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

// initial theme state
class ThemeInitial extends ThemeState {}

// theme changed state
class ThemeChanged extends ThemeState {
  final ThemeData themeData;

  const ThemeChanged({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
