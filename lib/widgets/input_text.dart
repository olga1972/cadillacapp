// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
//
// import '../variables.dart';
//
// class InputText extends StatefulWidget {
//   const InputText({Key? key, required this.name, required this.controller}) : super(key: key);
//   final String name, controller;
//   @override
//   State<InputText> createState() => _InputTextState();
// }
//
// class _InputTextState extends State<InputText> {
//   get name => null;
//
//   get controller => null;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       FormBuilderTextField(
//         name: name,
//         autofocus: true,
//         cursorWidth: 1.0,
//         cursorColor: Colors.white,
//         style: styleFormInput,
//         // decoration: ThemeHelper().textInputDecoration('', 'Введите ваш email', 'Введите ваш email'),
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.all(16),
//           border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.all(Radius.circular(10))
//           ),
//           fillColor: Color(0XFF515569),
//           filled: true,
//           hintText: '${name}',
//           hintStyle: TextStyle(
//             color: Colors.white60,
//           ),
//         ),
//         // onChanged: _onChanged,
//
//         valueTransformer: (text) => num.tryParse(text!),
//         autovalidateMode: AutovalidateMode.always,
//         // validator: _validateEmail,
//         controller: controller,
//         onSaved: (value) => name = value!,
//         validator: FormBuilderValidators.compose([
//           // FormBuilderValidators.required(context, errorText: 'Обязательное поле'),
//               (val) {
//             if (val == '') {
//               return 'Поле email не может быть пустым';
//             } else
//             if (!controller.text
//                 .contains('@')) {
//               // return 'Invalid email address';
//               return 'Неверный email адрес';
//             } else {
//               return null;
//             }
//           }
//
//           // FormBuilderValidators.max(context, 20),
//           // FormBuilderValidators.email(context),
//         ]),
//         keyboardType: TextInputType.emailAddress
//     );
//   }
//
// }