class StringUtil {
  // Remove last character fromj string
  static removeLs({dynamic data, dynamic character = ','}) {
    if (data.endsWith(character)) {
      return data.substring(0, data.length - 1);
    }
    //return data.replaceAll(",$", "");
  }
}
