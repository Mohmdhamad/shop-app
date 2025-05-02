abstract class AppStates {}

class AppInitialState extends AppStates{}
class ChangeBottomNavState extends AppStates{}
class LoadingHomeDataState extends AppStates{}
class SuccessHomeDataState extends AppStates{}
class ErrorHomeDataState extends AppStates{
  final String error;
  ErrorHomeDataState(this.error);
}