import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/controller/write_service.dart';
import 'package:river_pod_poc/src/model/model.dart';
import 'package:river_pod_poc/src/provider/userdata_provider.dart';



class HomePage extends ConsumerWidget {
   HomePage({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userDataProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: data.when(
            data: (data) => Column(
              children: data.map((e) => 
              SizedBox(
                width: 500,
                height: 100,
                child: ListTile(
                  title: Text(
                        'Name: ${e.name}',
              
                        style: TextStyle(
                fontSize: 20,
                        ),
                      ),
                      subtitle:Text(
                        'Age: ${e.age}',
              
                        style: TextStyle(
                fontSize: 20,
                        ),
                      ),
                ),
              ),
              ).toList()
            ),
      
            loading: () => const SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
      
            error: (a, b) => SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          )
        ),
      ),
      floatingActionButton: SizedBox(
        width: 500,
        height: 100,
        child: Row(
          children: [
            //name
           SizedBox(
            width: 100,
            height: 100,
            child: TextField(
              controller: userNameController,
            ),
           ) ,
           //age
           SizedBox(
            width: 100,
            height: 100,
            child: TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
            ),
           ) ,
           FloatingActionButton(
            onPressed: () {
              ref.read(writeProvider).writeUserToFirebase(
                UserModel()..name=userNameController.text..age=int.parse(ageController.text)
              );
            },
            child: Icon(Icons.add),
           ),
          ],
        ),
      ),
    );
  }
}