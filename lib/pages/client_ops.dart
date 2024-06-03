import 'package:easy_pos_r5/helpers/sql_helper.dart';
import 'package:easy_pos_r5/widgets/app_elevated_button.dart';
import 'package:easy_pos_r5/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ClientsOpsPage extends StatefulWidget {
  const ClientsOpsPage({super.key});

  @override
  State<ClientsOpsPage> createState() => _ClientsOpsPageState();
}

class _ClientsOpsPageState extends State<ClientsOpsPage> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                AppTextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    label: 'Name'),
                const SizedBox(
                  height: 20,
                ),
                AppTextFormField(
                    controller: emailController,
                    validator: (value) {},
                    label: 'email'),
                const SizedBox(
                  height: 20,
                ),
                 AppTextFormField(
                    controller: phoneController,
                    validator: (value) {},
                    label: 'phone'),
                const SizedBox(
                  height: 20,
                ),
                AppTextFormField(
                    controller: addressController,
                    validator: (value) {},
                    label: 'address'),
                const SizedBox(
                  height: 20,
                ),
                AppElevatedButton(
                  label: 'Submit',
                  onPressed: () async {
                    await onSubmit();
                  },
                ),
              ],
            )),
      ),
    );
  }

  Future<void> onSubmit() async {
    try {
      if (formKey.currentState!.validate()) {
        var sqlHelper = GetIt.I.get<SqlHelper>();
        await sqlHelper.db!.insert('clients', {
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'address': addressController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Client Saved Successfully')));
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error In Creating Client : $e')));
    }
  }
}
