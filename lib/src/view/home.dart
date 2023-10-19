import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_poc/src/controller/service.dart';
import 'package:river_pod_poc/src/model/user.dart';
import 'package:river_pod_poc/src/provider/data_provider.dart';

TextEditingController username = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
 bool isEdit = false; 
class HomePage extends ConsumerWidget {
  const HomePage({super.key});


  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataProvider = ref.watch(userDataProvider);
    
    return Scaffold(
      drawer: Drawer(
        child:ListView(
          children: [
             UserAccountsDrawerHeader(accountName: Text("Abhi"), accountEmail:  Text("abhi@atmega.in")),
          ],
        ),
      ),
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: dataProvider.when(
          data: (data) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(data.length, (index) => 
            SizedBox(
              height: 100,
              width: 500,
              child: ListTile(
                onTap: () {
                  username.text =  data[index].name;
                  agecontroller.text = data[index].age.toString();
                  isEdit = true;
                },
                onLongPress: () => ref.read(apiProvider).deleteUser(data[index].name),
                title: Text(
                  'Name: ${data[index].name}',
                style: TextStyle(
                  fontSize: 30,
                ),
                ),
              subtitle: Text(
                  'Email: ${data[index].age}',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
              ),
            ),
            ),
          ],
        ),

        loading: () => Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stackTrace) => Center(
          child: CircularProgressIndicator(color: Colors.red),
        ),
        ),
      ),

      floatingActionButton: SizedBox(
        height: 100,
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: TextField(
                controller: username,
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: TextField(
                controller: agecontroller,
              ),
            ),
            ElevatedButton(
              
              onPressed: () {
               isEdit ? ref.read(apiProvider).updateUser(UserModel()..name=username.text..age=int.parse(agecontroller.text)) : ref.read(apiProvider).writeUser(UserModel()..name=username.text..age=int.parse(agecontroller.text));
                username.clear();
                agecontroller.clear();
                isEdit = false;
              },
              child: isEdit ? Icon(Icons.edit_outlined) : Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}