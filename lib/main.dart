import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:next_location/data/model/contract_user_model.dart';
import 'package:next_location/data/model/documents_model.dart';
import 'package:next_location/data/model/invoice_model.dart';
import 'package:next_location/data/model/invoice_payment_model.dart';
import 'package:next_location/data/model/property_model.dart';
import 'package:next_location/data/model/review_item_model.dart';
import 'package:next_location/data/model/review_model.dart';
import 'package:next_location/data/model/user_model.dart';
import 'package:next_location/data/repository/amenities_repository.dart';
import 'package:next_location/data/repository/areas_repository.dart';
import 'package:next_location/data/repository/cities_repository.dart';
import 'package:next_location/data/repository/contracts_repository.dart';
import 'package:next_location/data/repository/countries_repository.dart';
import 'package:next_location/data/repository/documents_repository.dart';
import 'package:next_location/data/repository/invoices_repository.dart';
import 'package:next_location/data/repository/properties_repository.dart';
import 'package:next_location/data/repository/reviews_repository.dart';
import 'package:next_location/data/repository/users_repository.dart';
import 'package:next_location/data/repository/visits_repository.dart';
import 'package:next_location/firebase_options.dart';

FirebaseApp? firebaseApp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Next Location',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Next Location APIs Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = '';
  bool loading = false;

  void testFunction() async {
    setState(() {
      data = 'Getting Data';
      loading = true;
    });
    // PropertyModel? propertyModel =
    //     await PropertiesRepository().getPropertyById('saFyo7LUbxztEbHmiGsw');
    VisitsRepository().getOwnersPrevVisitsCount('5pJoZwxdkrz5c8iWrGah', 0).then(
      (value) {
        // if count
        data = value.toString();

        //  if list
        // data = value.isNotEmpty
        //     ? (value
        //         .map(
        //           (e) => e.toJson(),
        //         )
        //         .toString())
        //     : 'Empty List';

        //  if model
        // data = value?.toJson().toString() ?? 'No Model Found';
        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the testFunction method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                'Api Data',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                data,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: testFunction,
        tooltip: 'Test',
        child: loading
            ? Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  ),
                ),
              )
            : const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
