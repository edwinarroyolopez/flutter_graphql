import 'package:flutter/material.dart';
//import 'package:flutter_graphql/country_list.dart';
import 'package:graphql/client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: Home());
  }
}

Future<QueryResult> getAll(client, query) async {
  QueryOptions options = QueryOptions(
    document: query,
    variables: <String, dynamic>{},
  );
  var r = await client.query(options);
  print('&& && ');
  print(r);
  print('&& && ');
  return r;
}

class Home extends StatelessWidget {
  Widget projectWidget() {
    HttpLink httpLink = HttpLink(
      uri: 'https://countries.trevorblades.com/',
    );

    GraphQLClient _client = GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    );

    const String qReadCountries = '''
                    query ReadContinents {
                        continents{
                          name
                          code
                        }
                    }
                  ''';

    //var r = getAll(_client, qReadCountries);

    return FutureBuilder(
      builder: (context, projectSnap) {

        print('----  context');
        print(context);
        print('----  context');

        print('----  projectSnap');
        print(projectSnap);
        print('----  projectSnap');

      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return ListView.builder(
       // itemCount: projectSnap.data.length,
        itemBuilder: (context, index) {
         // Property project = projectSnap.data[index];
       //  print(projectSnap.data[index].images['images'][0]["url"]);
          return Column(
            children: <Widget>[
              Image.network('https://via.placeholder.com/120')// Widget to display the list of project
              //  Image.network(projectSnap.data[index].images['images'][0]["url"])// Widget to display the list of project
            ],
          );
        },
      );
    },
      future: getAll(_client, qReadCountries),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: projectWidget(),
    );
  }
}
