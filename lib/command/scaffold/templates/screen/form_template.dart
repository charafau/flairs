import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class FormTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  FormTemplate(this.appName, InputModel inputModel, {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_form.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/screen/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/screen/%%SNAKEMODEL%%.dart';
import 'package:flutter/material.dart';

class %%NAME%%Form extends StatefulWidget {
  final %%NAME%% %%NAMECAMEL%%;
  final Function(%%NAME%% %%NAMECAMEL%%) onSave;

  const %%NAME%%Form({
    Key key,
    this.%%NAMECAMEL%%,
    this.onSave,
  }) : super(key: key);

  @override
  _%%NAME%%FormState createState() => _%%NAME%%FormState();
}

class _%%NAME%%FormState extends State<%%NAME%%Form> {
  final _formKey = GlobalKey<FormState>();
  %%NAME%% _form%%NAME%%;

  @override
  void initState() {
    super.initState();
    if (widget.%%NAMECAMEL%% != null) {
      _form%%NAME%% = widget.%%NAMECAMEL%%.copy();
    } else {
      _form%%NAME%% = %%NAME%%();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: _form%%NAME%%.title,
              decoration: InputDecoration(labelText: 'Title'),
              onSaved: (v) {
                setState(() {
                  _form%%NAME%% = _form%%NAME%%.copy(title: v);
                });
              },
              validator: (val) {
                if (val.isEmpty) return "Please enter some text";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: _form%%NAME%%.body,
              decoration: InputDecoration(labelText: 'Body'),
              onSaved: (v) {
                setState(() {
                  _form%%NAME%% = _form%%NAME%%.copy(body: v);
                });
              },
              validator: (val) {
                if (val.isEmpty) return "Please enter some text";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    widget.onSave(_form%%NAME%%);
                  }
                },
                child: Text('Save'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
