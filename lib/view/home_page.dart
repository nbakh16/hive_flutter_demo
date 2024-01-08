import 'package:flutter/material.dart';
import 'package:hive_flutter_demo/boxes.dart';
import 'package:hive_flutter_demo/entity/person.dart';
import 'package:hive_flutter_demo/utils/field_validator.dart';
import 'no_data_available.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameTEController = TextEditingController();
  TextEditingController ageTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Hive Dive',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          boxPersons.isEmpty
              ? const SizedBox()
              : Tooltip(
                  message: 'Delete All',
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        ///clear all
                        boxPersons.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPersonBottomSheet,
        child: const Icon(Icons.add),
      ),
      body: Visibility(
        visible: boxPersons.isNotEmpty,
        replacement: const NoDataAvailable(),
        child: ListView.builder(
          itemCount: boxPersons.length,
          itemBuilder: (context, index) {
            Person person = boxPersons.getAt(index);
            return ListTile(
              title: Text(
                'Name: ${person.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                'Age: ${person.age}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        boxPersons.deleteAt(index);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade400,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      updatePersonBottomSheet(index);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.teal.shade400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void addPerson(String name, String age) {
    setState(() {
      // boxPersons.put(
      //   'key_$name',
      //   Person(
      //     name: name,
      //     age: int.parse(age),
      //   ),
      // );
      boxPersons.add(
        Person(
          name: name,
          age: int.parse(age),
        ),
      );
      nameTEController.clear();
      ageTEController.clear();
      Navigator.pop(context);
    });
  }

  void addPersonBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.teal),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameTEController,
                      decoration: const InputDecoration(
                          label: Text('Name'), hintText: 'Name'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: validateField,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: ageTEController,
                      decoration: const InputDecoration(
                          label: Text('Age'), hintText: 'Age'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          addPerson(
                            nameTEController.text,
                            ageTEController.text,
                          );
                        }
                      },
                      validator: validateField,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addPerson(
                      nameTEController.text,
                      ageTEController.text,
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void updatePerson(int index, String name, String age) {
    setState(() {
      boxPersons.putAt(
        index,
        Person(
          name: name,
          age: int.parse(age),
        ),
      );
      nameTEController.clear();
      ageTEController.clear();
      Navigator.pop(context);
    });
  }

  void updatePersonBottomSheet(int index) {
    Person person = boxPersons.getAt(index);
    nameTEController.text = person.name;
    ageTEController.text = person.age.toString();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.teal),
              ),
              const SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameTEController,
                      decoration: const InputDecoration(
                          label: Text('Name'), hintText: 'Name'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: validateField,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: ageTEController,
                      decoration: const InputDecoration(
                          label: Text('Age'), hintText: 'Age'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          updatePerson(
                            index,
                            nameTEController.text,
                            ageTEController.text,
                          );
                        }
                      },
                      validator: validateField,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updatePerson(
                      index,
                      nameTEController.text,
                      ageTEController.text,
                    );
                  }
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
