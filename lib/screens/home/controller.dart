import 'package:ielts/base/index.dart';
import 'package:ielts/screens/sign_in/index.dart';
import '../../index.dart';

class HomeController extends BaseController {
  ServerRepository serverRepo = ServerRepository();
  final store = PreferenceImpl();

  Future getCourse() async {
    String ssId = SignInController.to.getSessionId();
    // var getCourse = serverRepo.getCourse(ssId);
    // callDataService(getLevel);
  }

  @override
  void onReady() {
    getCourse();
    super.onReady();
  }
}
