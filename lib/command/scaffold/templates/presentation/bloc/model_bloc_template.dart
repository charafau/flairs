import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class ModelBlocTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  ModelBlocTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_bloc.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/bloc/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """

import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/usecase/delete_%%SNAKEMODEL%%_usecase.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/usecase/get_%%SNAKEMODEL%%s_usecase.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/usecase/post_%%SNAKEMODEL%%_usecase.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/usecase/update_%%SNAKEMODEL%%_usecase.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_event.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class %%NAME%%Bloc extends Bloc<%%NAME%%Event, %%NAME%%State> {
  final Get%%NAME%%sUseCase get%%NAME%%sUseCase;
  final Post%%NAME%%UseCase post%%NAME%%UseCase;
  final Update%%NAME%%UseCase update%%NAME%%UseCase;
  final Delete%%NAME%%UseCase delete%%NAME%%UseCase;

  %%NAME%%Bloc({
    @required this.post%%NAME%%UseCase,
    @required this.get%%NAME%%sUseCase,
    @required this.update%%NAME%%UseCase,
    @required this.delete%%NAME%%UseCase,
  }) : super(%%NAME%%Loading());

  @override
  Stream<%%NAME%%State> mapEventToState(%%NAME%%Event event) async* {
    if (event is Load%%NAME%%s) {
      yield await _fetch%%NAME%%s();
    } else if (event is Add%%NAME%%) {
      final resultEither = await post%%NAME%%UseCase(event.%%NAMECAMEL%%);
      if (resultEither.isRight()) {
        final %%NAME%%State state = await _fetch%%NAME%%s();

        if (state is %%NAME%%sLoaded) {
          yield %%NAME%%SuccessfullyCreated(state.%%NAMECAMEL%%s, state.%%NAMECAMEL%%s.length - 1);
        } else {
          yield state;
        }
      }
    } else if (event is Update%%NAME%%) {
      final resultEither = await update%%NAME%%UseCase(event.%%NAMECAMEL%%);
      if (resultEither.isRight()) {
        final result = resultEither.fold(
          (fail) => %%NAME%%EditFailed(),
          (%%NAMECAMEL%%) => %%NAME%%SuccessfullyUpdated(%%NAMECAMEL%%),
        );

        yield result;

        yield await _fetch%%NAME%%s();
      }
    } else if (event is Delete%%NAME%%) {
      final resultEither = await delete%%NAME%%UseCase(event.%%NAMECAMEL%%);
      if (resultEither.isRight()) {
        resultEither.fold(
          (fail) => %%NAME%%DeleteFailed(),
          (data) => %%NAME%%DeletedSuccessfylly(),
        );

        yield await _fetch%%NAME%%s();
      }
    } else if (event is Refresh%%NAME%%s) {
      final %%NAMECAMEL%%sEither = await get%%NAME%%sUseCase();
      final result = %%NAMECAMEL%%sEither.fold(
        (fail) => %%NAME%%sNotLoaded(),
        (data) => %%NAME%%sLoaded(data),
      );
      yield %%NAME%%Refreshed();

      yield result;
    }
  }

  Future<%%NAME%%State> _fetch%%NAME%%s() async {
    final %%NAMECAMEL%%sEither = await get%%NAME%%sUseCase();
    return %%NAMECAMEL%%sEither.fold(
      (fail) => %%NAME%%sNotLoaded(),
      (data) => %%NAME%%sLoaded(data),
    );
  }
}


    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
