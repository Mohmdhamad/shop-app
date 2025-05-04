abstract class AppStates {}

class AppInitialState extends AppStates{}
class ChangeBottomNavState extends AppStates{}
class LoadingHomeDataState extends AppStates{}
class SuccessHomeDataState extends AppStates{}
class ErrorHomeDataState extends AppStates{
  final String error;
  ErrorHomeDataState(this.error);
}
class SuccessCategoriesDataState extends AppStates{}
class ErrorCategoriesDataState extends AppStates{
  final String error;
  ErrorCategoriesDataState(this.error);
}

