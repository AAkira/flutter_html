import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'flutter_html Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

const htmlData = """
<h1>Header 1</h1>
<h2>Header 2</h2>
<h3>Header 3</h3>
<h4>Header 4</h4>
<h5>Header 5</h5>
<h6>Header 6</h6>
      <p>
        <ruby>
          漢<rt>かん</rt>
          字<rt>じ</rt>
        </ruby>
        &nbsp;is Japanese Kanji.
        <br />
        <ruby>漢<rt>ㄏㄢˋ</rt>字<rt>ㄗˋ</rt></ruby> is Traditional Chinese.
        <br />
        <ruby>汉<rt>hàn</rt>字<rt>zì</rt></ruby> is Simplified Chinese
        <br />
        <ruby>
          <ruby>HT<rt>Hypertext</rt>M<rt>Markup</rt>L<rt>Language</rt></ruby>
          <rt>An abstract language for describing documents and applications
        </ruby>
      </p>
      Solve for <var>x<sub>n</sub></var>: log<sub>2</sub>(<var>x</var><sup>2</sup>+<var>n</var>) = 9<sup>3</sup>
      <p>One of the most common equations in all of physics is <var>E</var>=<var>m</var><var>c</var><sup>2</sup>.<p>
      <table>
      <colgroup>
        <col width="50%" />
        <col width="25%" />
        <col width="25%" />
      </colgroup>
      <thead>
      <tr><th>One</th><th>Two</th><th>Three</th></tr>
      </thead>
      <tbody>
      <tr>
        <td>Data</td><td>Data</td><td>Data</td>
      </tr>
      <tr>
        <td>Data</td><td>Data</td><td>Data</td>
      </tr>
      </tbody>
      <tfoot>
      <tr><td>fData</td><td>fData</td><td>fData</td></tr>
      </tfoot>
      </table>
      <flutter></flutter>
      <svg id='svg1' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'>
            <circle r="32" cx="35" cy="65" fill="#F00" opacity="0.5"/>
            <circle r="32" cx="65" cy="65" fill="#0F0" opacity="0.5"/>
            <circle r="32" cx="50" cy="35" fill="#00F" opacity="0.5"/>
      </svg>
      <ol>
            <li>This</li>
            <li><p>is</p></li>
            <li>an</li>
            <li>
            ordered
            <ul>
            <li>With<br /><br />...</li>
            <li>a</li>
            <li>nested</li>
            <li>unordered
            <ol>
            <li>With a nested</li>
            <li>ordered list.</li>
            </ol>
            </li>
            <li>list</li>
            </ul>
            </li>
            <li>list! Lorem ipsum dolor sit <b>amet cale aaihg aie a gama eia aai aia ia af a</b></li>
            <li><h2>Header 2</h2></li>
            <h2><li>Header 2</li></h2>
      </ol>
""";

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data: htmlData,
                  //Optional parameters:
                  style: {
                    "html": Style(
                      backgroundColor: Colors.black,
                      color: Colors.white,
                    ),
                    "a": Style(
                      color: Colors.red,
                    ),
                    "li": Style(
//              backgroundColor: Colors.red,
//                fontSize: FontSize(20),
//                margin: const EdgeInsets.only(top: 32),
                        ),
                    "h1, h3, h5": Style(
//                backgroundColor: Colors.deepPurple,
//                alignment: Alignment.center,
                        ),
                    "#whitespace": Style(
                      backgroundColor: Colors.deepPurple,
                    ),
                    "table": Style(
                      backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    ),
                    "tr": Style(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    "th": Style(
                      padding: EdgeInsets.all(6),
                      backgroundColor: Colors.grey,
                    ),
                    "td": Style(
                      padding: EdgeInsets.all(6),
                      backgroundColor: Colors.transparent,
                    ),
                    "var": Style(fontFamily: 'serif'),
                  },
                  customRender: {
                    "flutter": (RenderContext context, Widget child, attributes) {
                      return FlutterLogo(
                        style: (attributes['horizontal'] != null)
                            ? FlutterLogoStyle.horizontal
                            : FlutterLogoStyle.markOnly,
                        textColor: context.style.color,
                        size: context.style.fontSize.size * 5,
                      );
                    }
                  },
                  onLinkTap: (url) {
                    print("Opening $url...");
                  },
                  onImageTap: (src) {
                    print(src);
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  HtmlParser.cleanTree(HtmlParser.applyCSS(
                          HtmlParser.lexDomTree(HtmlParser.parseHTML(htmlData), [], []), null))
                      .toString(),
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
