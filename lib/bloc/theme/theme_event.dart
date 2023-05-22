part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

// change the theme
class ChangeTheme extends ThemeEvent {
  final ThemeData themeData;

  const ChangeTheme({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
