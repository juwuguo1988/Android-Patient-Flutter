enum Env {
  PROD,
  DEV,
  TEST,
}

class Configs {
  static String apiHost(env) {
    switch (env) {
      case Env.PROD:
        return "https://api.xinzhili.cn/v0/";
      case Env.DEV:
        return "https://api.test.xzlcorp.com/v0/";
      case Env.TEST:
      default:
        return "https://api.test.xzlcorp.com/v0/";
    }
  }
}
