



class Overseer {
  Map<dynamic, dynamic> repository = {};

  static int HR=0;
  static int SPO2=0;
  static int ABP_low=0;
  static int ABP_high=0;
  static int RESP=0;




  Overseer() {



// register managers
  }

  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  // register the manager to this overseer to store in repository
  register(name, object) {
    repository[name] = object;
  }

  // get the required manager from overseer when needed
  fetch(name) {
    return repository[name];
  }
}
