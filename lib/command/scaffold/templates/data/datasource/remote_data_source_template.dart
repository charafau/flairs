import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RemoteDataSourceTemplate extends ParamFileTemplate {
  RemoteDataSourceTemplate(InputModel inputModel) : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase('${inputModel.modelName}_local_data_source.dart');
    return rc.snakeCase;
  }

  @override
  String filePath() {
    return './main/data/datasource/';
  }

  @override
  String template() {
    final rc = ReCase(inputModel.modelName);

    final t = '''
    import 'dart:convert';

    import 'package:clean_arch_trivia/core/error/exception.dart';
    import 'package:clean_arch_trivia/features/number_trivia/data/dto/number_trivia_dto.dart';
    import 'package:http/http.dart' as http;
    import 'package:meta/meta.dart';

    abstract class %%NAME%%RemoteDataSource {
      Future<%%NAME%%Dto> getConcrete%%NAME%%(int number);

      Future<%%NAME%%Dto> getRandom%%NAME%%();
    }

    class %%NAME%%RemoteDataSourceImpl implements %%NAME%%RemoteDataSource {
      final http.Client client;

      %%NAME%%RemoteDataSourceImpl({@required this.client});

//      @override
//      Future<%%NAME%%Dto> getConcreteNumberTrivia(int number) =>
//          _getTriviaFromUrl('http://numbersapi.com/');

      @override
      Future<%%NAME%%Dto> getRandomNumberTrivia() =>
          _getTriviaFromUrl('http://numbersapi.com/random');

      Future<%%NAME%%Dto> _getTriviaFromUrl(String url) async {
        final response = await client.get(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          return %%NAME%%Dto.fromJson(json.decode(response.body));
        } else {
          throw ServerException();
        }
      }
    }

    ''';
    var tt = t.replaceAll('%%NAME%%', rc.pascalCase);
    tt = tt.replaceAll('%%NAMECONSTANT%%', rc.constantCase);
    tt = tt.replaceAll('%%NAMECAMEL%%', rc.camelCase);

    return tt;
  }
}
