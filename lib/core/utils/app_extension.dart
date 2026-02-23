
class Dbg {
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';

  static void p(String msg, {String color = _cyan}) {
    // if (kDebugMode) {
      print('${color}[DBG]=> $msg$_reset');
    // }
  }

  static void pRed(String msg) => p(msg, color: _red);
  static void pGreen(String msg) => p(msg, color: _green);
  static void pYellow(String msg) => p(msg, color: _yellow);
  static void pBlue(String msg) => p(msg, color: _blue);
}


// Importent
// Dbg.p("This is a default cyan message.");
// Dbg.pRed("This is a red error message.");
// Dbg.pGreen("This is a green success message.");
// Dbg.pYellow("This is a yellow warning message.");
// Dbg.pBlue("This is a blue info message.");




