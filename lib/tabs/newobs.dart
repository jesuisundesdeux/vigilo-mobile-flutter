import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'mymap.dart';

class NewObservation extends StatefulWidget {
  NewObservation(this.theme);
  final ThemeData theme;
  @override
  _NewObservationState createState() => new _NewObservationState(theme);
}

class _NewObservationState extends State<NewObservation> {
  _NewObservationState(this.theme);

  final ThemeData theme;

  int current = 0;

  File _imageFile;
  Image _image = Image.asset("assets/images/jeSuisUnDesDeux.png", width: 32);



  pickPhoto(ImageSource source) => () async {
        var imageFile = await ImagePicker.pickImage(source: source);

        setState(() {
          _imageFile = imageFile;
          _image = Image.file(_imageFile);
        });
      };

  bool canContinue() {
    switch(current){
      case 0  : return _imageFile != null;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      new Step(
          subtitle: Text("Pick a picture"),
          title: Row(children: [
            RaisedButton(
              color: theme.accentColor,
              child: Icon(Icons.camera),
              onPressed: pickPhoto(ImageSource.camera),
            ),
            RaisedButton(
              color: theme.accentColor,
              child: Icon(Icons.photo_album),
              onPressed: pickPhoto(ImageSource.gallery),
            )
          ]),
          content: _image,
          isActive: true),
      new Step(
          title: Text("Geo"),
          content: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100, maxHeight: 400, minWidth: 100, maxWidth: 300),
            child: MyMap()),
          isActive: _imageFile != null),
      new Step(title: Text("Desc"), content: new Text("Hello!"), isActive: true)
    ];

    return new Scaffold(
        appBar: AppBar(
            title: Text("New Observation"), backgroundColor: theme.accentColor),
        body: Theme(
            data: theme,
            child: new Stepper(
              currentStep: current,
              steps: steps,
              type: StepperType.vertical,
              onStepTapped: (step) {
                setState(() {
                  current = step;
                });
              },
              onStepCancel: () {
                // On hitting cancel button, change the state
                setState(() {
                  // update the variable handling the current step value
                  // going back one step i.e subtracting 1, until its 0
                  if (current > 0) {
                    current = current - 1;
                  } else {
                    current = 0;
                  }
                });
                // Log function call
                print("onStepCancel : " + current.toString());
              },
              onStepContinue: () {
                setState(() {
                  // update the variable handling the current step value
                  // going back one step i.e adding 1, until its the length of the step
                  if (current < steps.length - 1) {
                    current = current + 1;
                  } else {
                    current = 0;
                  }
                });
                // Log function call
                print("onStepContinue : " + current.toString());
              },
              controlsBuilder: 
              
              
              (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
         return Row(
           children: <Widget>[
             FlatButton(
               color: Theme.of(context).accentColor,
               onPressed: canContinue()? onStepContinue : null,
               child: const Text('CONTINUE'),
               
             ),
             FlatButton(
               onPressed: onStepCancel,
               child: const Text('CANCEL'),
             ),
           ],
         );}
              
              
              
              ,
            )));
  }
}
