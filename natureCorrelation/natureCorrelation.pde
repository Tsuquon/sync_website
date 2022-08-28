

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void setup() {

  int[] urls = {284,322,332,358,489,861,896,1029,1081,1233,1240,1935,2787,2265,3021,2882,2992,3096};
  mergeSets(urls, "sociology");



  String[] filenames = listFileNames("/home/johns/sketchbook/nature/processedOutputs");
  JSONArray values = new JSONArray();



  //String[] article1 = loadStrings("/home/johns/sketchbook/nature/processedOutputs/925_output.txt");
  //String[] article2 = loadStrings("/home/johns/sketchbook/nature/processedOutputs/949_output.txt");
  String[] article2 = loadStrings("/home/johns/sketchbook/nature/PROFILE_sociology.txt");
  float[] arr2 = new float[22303];
  for (int i = 0; i < article2.length; i++)
    arr2[Integer.parseInt(article2[i].substring(0, article2[i].indexOf(" ")))] = Float.parseFloat(article2[i].substring(article2[i].indexOf(" ") + 1));

  for (int e = 0; e < filenames.length; e ++) {
    String[] article1 = loadStrings("/home/johns/sketchbook/nature/processedOutputs/" + filenames[e]);
    //String[] article2 = loadStrings("/home/johns/sketchbook/nature/processedOutputs/1352_output.txt");
    float[] arr1 = new float[22303];
    //println(arr1[10]);
    for (int i = 0; i < article1.length; i++)
      arr1[Integer.parseInt(article1[i].substring(0, article1[i].indexOf(" ")))] = Float.parseFloat(article1[i].substring(article1[i].indexOf(" ") + 1));

    JSONObject entry = new JSONObject();

    entry.setInt("id", Integer.parseInt(filenames[e].substring(0, filenames[e].indexOf("_"))));
    entry.setFloat("val", (float)cossim(arr1, arr2));
    values.setJSONObject(e, entry);

    println("Calculated ", filenames[e]);
  }
  
  saveJSONArray(values, "updates.json");
}


void mergeSets(int[] ids, String name) {
  float[] outArr = new float[22303];
  float sum = 0;
  for (int i = 0; i < ids.length; i ++) {
    String[] arr = loadStrings("/home/johns/sketchbook/nature/processedOutputs/" + str(ids[i]) + "_output.txt");
    for (int e = 0; e < arr.length; e++)
      outArr[Integer.parseInt(arr[e].substring(0, arr[e].indexOf(" ")))] += Float.parseFloat(arr[e].substring(arr[e].indexOf(" ") + 1));
  }

  String[] out = new String[outArr.length];
  int ind = 0;
  for (int i = 0; i < outArr.length; i ++) {
    if (outArr[i] != 0) {
      out[ind] = Integer.toString(i) +  " " + Float.toString(outArr[i]);// / ids.length);
      sum += (outArr[i]);
      ind ++;
    }
  }
  String[] tmp = new String[ind];
  arrayCopy(out, 0, tmp, 0, ind);
  println("Saving out");
  printArray(tmp);
  println(sum);

  saveStrings("/home/johns/sketchbook/nature/PROFILE_" + name + ".txt", tmp);
}





double cossim(float[] a1, float[] a2) {
  double sum = 0;
  double denom1 = 0;
  double denom2 = 0;
  for (int i = 0; i < 22303; i ++) {
    sum += a1[i] * a2[i];
    denom1 += a1[i] *a1[i];
    denom2 += a2[i] *a2[i];
  }

  return sum / (sqrt((float)denom1) * sqrt((float)denom2));
}


double Correlation(float[] xs, float[] ys) {
  //TODO: check here that arrays are not null, of the same length etc

  double sx = 0.0;
  double sy = 0.0;
  double sxx = 0.0;
  double syy = 0.0;
  double sxy = 0.0;

  int n = xs.length;

  for (int i = 0; i < n; ++i) {
    double x = xs[i];
    double y = ys[i];

    sx += x;
    sy += y;
    sxx += x * x;
    syy += y * y;
    sxy += x * y;
  }

  // covariation
  double cov = sxy / n - sx * sy / n / n;
  // standard error of x
  double sigmax = Math.sqrt(sxx / n -  sx * sx / n / n);
  // standard error of y
  double sigmay = Math.sqrt(syy / n -  sy * sy / n / n);

  // correlation is just a normalized covariation
  return cov / sigmax / sigmay;
}
