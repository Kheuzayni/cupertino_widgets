import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptivePage extends StatefulWidget {

  final TargetPlatform platform;

  AdaptivePage({required this.platform});

  @override
  AdpativePageState createState() => AdpativePageState();
}

class AdpativePageState extends State<AdaptivePage> {
  bool loveFlutter = true;
  bool switchValue = true;
  double minValue = 0;
  double maxValue = 100;
  double currentValue = 25;
  String text = "";
  int groupValue = 0;

  List<Text> animals = [
    Text("Chien"),
    Text("Chat"),
    Text("Hérisson"),
    Text("Geai"),
    Text("Scorpion"),
  ];

  @override
  Widget build(BuildContext context) {
    return scaffold();
  }

  bool isiOS() => (widget.platform == TargetPlatform.iOS);

  Widget scaffold() {
    return (isiOS())
        ? CupertinoPageScaffold(navigationBar: navBar(),child: body())
        : Scaffold(appBar: appBar(), body: body());
  }

  AppBar appBar() {
    return AppBar(title: const Text("Notre design sous Android"));
  }

  CupertinoNavigationBar navBar() {
    return const CupertinoNavigationBar(middle: Text("Notre design sous iOS"), backgroundColor: Colors.red);
  }

  Widget body() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 8),),
        button(),
        Divider(),
        switchRow(),
        Divider(),
        sliderColumn(),
        Divider(),
        textFields(),
        Text(text),
        Divider(),
        btnAlert(),
        fab(),
        picker()

      ],
    );
  }

  Widget button() {
    return (isiOS())
        ? CupertinoButton(child: textButton(), onPressed: onButtonPressed, color: Colors.red,)
        : ElevatedButton(onPressed: onButtonPressed, child: textButton());
  }

  Text textButton() {
    return Text((loveFlutter) ? "I Love Flutter": "React Js is my Favorite");
  }

  void onButtonPressed() {
    setState(() {
      loveFlutter = !loveFlutter;
    });
  }

  Row switchRow() => Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text((switchValue) ? "Je suis vrai": 'Je suis faux'),
      switchAdaptive()
    ],
  );

  Widget switchAdaptive() {
    return (isiOS())
        ? CupertinoSwitch(value: switchValue, onChanged: onSwitchChanged)
        : Switch(value: switchValue, onChanged: onSwitchChanged);
  }

  void onSwitchChanged(bool newValue) =>setState(() => switchValue = newValue);

  Widget slider() {
    return (isiOS())
        ? CupertinoSlider(value: currentValue, onChanged: onSliderChanged, min: minValue, max: maxValue,)
        : Slider(value: currentValue, onChanged: onSliderChanged, min: minValue, max: maxValue,);
  }

  onSliderChanged(double newValue) {
    setState(() {
      currentValue = newValue;
    });
  }

  Column sliderColumn() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Min: ${minValue.toInt().toString()}"),
            Text("Max: ${maxValue.toInt().toString()}")
          ],
        )  ,
        slider(),
        Text(currentValue.toInt().toString())
      ],
    );
  }

  Widget textFields() {
    return (isiOS())
        ? CupertinoTextField(onSubmitted: submittedText, placeholder: "Entrez qqchose",)
        : TextField(onSubmitted: submittedText, decoration: InputDecoration(hintText: "Entrez quelquechose"),);
  }

  submittedText(String newValue) {
    setState(() {
      text = newValue;
    });
  }

  Widget btnAlert() {
    final iOS = isiOS();
    final Text text = Text("Appuyez ici pour montrer une alerte");
    final CupertinoButton iOSbtn = CupertinoButton(child: text, onPressed: (() => showAlert()));
    final TextButton androidBtn = TextButton(onPressed: (() => showAlert()), child: text);
    return iOS ? iOSbtn : androidBtn;
  }

  Future<void> showAlert() async {
    final title = Text("Notre première alerte");
    final content = Text("Super! vous avez réussi à montrer une alerte");
    final iOSAlert = CupertinoAlertDialog(title: title, content: content, actions: actions(),);
    final androidAlert = AlertDialog(title: title, content: content, actions: actions(),);
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext buildContext) {
          return (isiOS()) ? iOSAlert : androidAlert;
        });
  }

  List<Widget> actions() {
    List<Widget> androidActions = [
      TextButton(child: Text("OK"), onPressed: () {
        Navigator.of(context).pop();
      })
    ];

    List<Widget> iOSActions = [
      CupertinoDialogAction(child: Text("OK"), onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          currentValue = 88;
        });
      },
        isDestructiveAction: false,
      ),
      CupertinoDialogAction(child: Text("Annuler"), onPressed: () {
        Navigator.of(context).pop();
      },
        isDestructiveAction: true,
      )
    ];
    return (isiOS()) ? iOSActions : androidActions;
  }

  Widget actionSheet() {
    return CupertinoActionSheet(
      title: Text("Notre ActionSheet"),
      message: Text("Notre message"),
      actions: [
        CupertinoDialogAction(child: Text("Oui"), onPressed: close,),
        CupertinoDialogAction(child: Text("Non"), onPressed: close,),
        CupertinoDialogAction(child: Text("Peut-être"), onPressed: close,),
      ],
    );
  }

  FloatingActionButton fab() {
    return FloatingActionButton(
        child: Icon(Icons.apartment),
        onPressed: () {
          if (isiOS()) {
            showDialog(context: context, builder: (BuildContext ctx) {
              return actionSheet();
            });
          }

        });
  }

  void close() {
    Navigator.of(context).pop();
  }

  Widget picker() {
    return (!isiOS())
        ? Container()
        : Column(
      children: [
        CupertinoPicker(
          itemExtent: 100,
          onSelectedItemChanged: (int index) {
            setState(() {
              print("Mon index est: $index");
            });
          },
          children: animals,
          diameterRatio: 0.2,
          backgroundColor: Colors.redAccent.shade200,

        ),
        CupertinoSegmentedControl(
            groupValue: groupValue,
            children: m(),
            onValueChanged: (int index) {

            }
        ),
        CupertinoSlidingSegmentedControl(
            groupValue: groupValue,
            children: m(),
            onValueChanged: (int? index) {
              setState(() {
                groupValue = index ?? 0;
              });
            })

      ],
    );
  }

  Map<int, Widget> m() {
    Map<int, Widget> newMap = {};
    for (var x  = 0; x < animals.length; x++) {
      newMap[x] = animals[x];
    }
    return newMap;
  }

}