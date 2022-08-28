import java.util.HashSet; // import the HashMap class
import java.util.Set; // import the HashMap class
import java.util.ArrayList; // import the HashMap class
import java.util.List; // import the HashMap class
void setup() {
  
  String[] fn = listFileNames(sketchPath("outputs3kw2"));
  JSONArray values = new JSONArray();

  for (int i = 0; i < fn.length; i++) {
    int id = Integer.parseInt(fn[i].substring(0,fn[i].indexOf("_")));
    String content = loadStrings(sketchPath("outputs3kw2") + "/" + fn[i])[0];
        
    JSONObject entry = new JSONObject();

        entry.setInt("id", id);
        entry.setString("content", content);

        values.setJSONObject(i, entry);
        println(i);
  }
  
    saveJSONArray(values, "kws.json");

  
  if(1==1)
  return;
  
  
  
  
  
  
  
  Set<String> set = new HashSet<String> ();

  // Using just the path of this sketch to demonstrate,
  // but you can list any directory you like.
  String path = sketchPath("dictOutputs");

  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);

  for (int i = 0; i < filenames.length; i ++) {
    String[] txt = loadStrings("dictOutputs/" + filenames[i]);
    for (int e = 0; e < txt.length; e++) {
      int dp = txt[e].indexOf('.');
      int ep = txt[e].indexOf(' ');
      int qp = txt[e].indexOf('?');
      if (dp != -1 && dp < ep)
        ep = dp;
      if (qp != -1 && qp < ep)
        ep = qp;

      String tx = txt[e].substring(0, ep)
        .replace("'", "")
        .replace("\"", "")
        .replace(")", "")
        .replace("(", "")
        .replace("[", "")
        .replace("]", "")
        .replace("{", "")
        .replace("}", "")
        .replace("%", "");

      if (!tx.matches("-?\\d+") && tx.length() > 3)
        set.add(tx);
    }
    println("Done", filenames[i]);
  }
  saveStrings("out.txt", set.toArray(String[]::new));
  List<String> mainDict = new ArrayList<>(set);

  // Now process each dict individually
  for (int i = 0; i < filenames.length; i++) {
    HashMap<Integer, Float> occ = new HashMap<Integer, Float>();
    float total_occs = 0;
    String[] txt = loadStrings("dictOutputs/" + filenames[i]);
    for (int e = 0; e < txt.length; e++) {
      int dp = txt[e].indexOf('.');
      int sp = txt[e].indexOf(' ');
      int qp = txt[e].indexOf('?');
      int ep = sp;
      if (dp != -1 && dp < ep)
        ep = dp;
      if (qp != -1 && qp < ep)
        ep = qp;

      String tx = txt[e].substring(0, ep)
        .replace("'", "")
        .replace("\"", "")
        .replace(")", "")
        .replace("(", "")
        .replace("[", "")
        .replace("]", "")
        .replace("{", "")
        .replace("}", "")
        .replace("%", "");

      if (!tx.matches("-?\\d+") && tx.length() > 3) {
        float num_occrs = Float.parseFloat(txt[e].substring(sp + 1));
        total_occs += num_occrs;
        occ.merge(mainDict.indexOf(tx), num_occrs, Float::sum);
      }
    }
    // Export as txt
    String[] out = new String[occ.size()];
    int ii = 0;
    for (Integer name : occ.keySet()) {

      String key = name.toString();
      String value = str(occ.get(name)/total_occs);
      //System.out.println(mainDict.get(name) + " " + key + " " + value);
      out[ii] = key + " " + value;
      ii++;
    }
    saveStrings("processedOutputs/" + filenames[i], out);
    println("processed", filenames[i]);
  }
  exit();
}

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


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//void setup() {
//  JSONArray values = new JSONArray();
//  int ind = 0;
//  for (int j = 1; j < 645; j ++) {
//    String[] txt = loadStrings("/home/johns/sketchbook/nature/data/search?order=date_desc&article_type=news,+news-and-views,+editorial,+special-features&page=" + str(j));
//    txt = join(txt, '\n').split("<article ");

//    for (int i = 0; i < txt.length; i ++) {
//      try {
//        int end = txt[i].indexOf("</article>");
//        if (end == -1)
//          continue;
//        txt[i] = txt[i].substring(0, end);

//        int title_start = txt[i].indexOf("data-track-label=\"link\">") + "data-track-label=\"link\">".length();
//        int ti = txt[i].indexOf("</a>", title_start);
//        if (ti == -1)
//          continue;
//        String title = txt[i].substring(title_start, ti);

//        int author_start = txt[i].indexOf("itemprop=\"name\">") + "itemprop=\"name\">".length();
//        int ai = txt[i].indexOf("</span>", author_start);
//        if (ai == -1)
//          continue;
//        String author = txt[i].substring(author_start, ai);
//        txt[i] = txt[i].replace("  ", "").replace("  ", "").replace("  ", "");

//        int desc_start = txt[i].indexOf("itemprop=\"description\">\n<p>") + "itemprop=\"description\">\n<p>".length();
//        int ddi = txt[i].indexOf("</p>", desc_start);
//        if (ddi == -1)
//          continue;
//        String desc = txt[i].substring(desc_start, ddi);

//        int img_start = txt[i].indexOf("<img src=\"//") + "<img src=\"//".length();
//        int ii = txt[i].indexOf("\"\n", img_start);
//        if (ii == -1)
//          continue;
//        String img = txt[i].substring(img_start, ii);



//        int date_start = txt[i].indexOf("itemprop=\"datePublished\">") + "itemprop=\"datePublished\">".length();
//        int di =txt[i].indexOf("</time>", date_start);
//        if (di == -1)
//          continue;
//        String date = txt[i].substring(date_start, di);



//        int url_start = txt[i].indexOf("itemprop=\"name headline\">\n<a href=\"") + "itemprop=\"name headline\">\n<a href=\"".length();
//        int ui = txt[i].indexOf("\"\n", url_start);
//        if (ui == -1)
//          continue;
//        String url = "https://www.nature.com" + txt[i].substring(url_start, ui);


//        if (title.contains("</") || desc.contains("</") || img.contains("</") || url.contains("</") || date.contains("</") || author.contains("</") )
//          continue;

//        println(title);

//        println(author);

//        println(desc);

//        println(img);

//        println(date);

//        println(url);


//        JSONObject entry = new JSONObject();

//        entry.setString("title", title);
//        entry.setString("description", desc);
//        entry.setString("imgurl", img);
//        entry.setString("url", url);
//        entry.setString("date", date);
//        entry.setString("author", author);

//        values.setJSONObject(ind, entry);
//        ind++;
//        //println(txt[i]);
//        //    return;
//      }
//      catch(Exception e) {
//        e.printStackTrace();
//      }
//    }
//  }




//  saveJSONArray(values, "data/articles.json");
//  exit();
//  //XML[] children = xml.getChildren();//"animal");
//  //printArray(txt);

//  //for (int i = 0; i < children.length; i++) {
//  //  int id = children[i].getInt("id");
//  //  String coloring = children[i].getString("species");
//  //  String name = children[i].getContent();
//  //  println(id + ", " + coloring + ", " + name);
//  //}
//}
