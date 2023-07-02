
import 'package:bonfire/bonfire.dart';
import 'Bar_Life.dart';

class KnightInterface extends GameInterface {
  @override
  Future<void> onLoad() async {
    add(BarLife_Component());
    return super.onLoad();
  }


}