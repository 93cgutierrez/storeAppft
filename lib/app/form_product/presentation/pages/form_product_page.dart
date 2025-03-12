import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_state.dart';
import 'package:storeapp/app/util/log.util.dart';
import 'package:storeapp/app/util/validation.util.dart';

const String _tag = 'FormProductPage';

class FormProductPage extends StatelessWidget {
  //add
  static const String name = 'formProductPage';
  static const String _tag = name;
  static const String link = '/$name';

  //update
  static const String nameUpdate = 'formProductPage-update';
  static const String idKey = 'id';
  static const String linkUpdate = '/$nameUpdate/:$idKey';

  final String? id;

  const FormProductPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<FormProductBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            id == null ? "Agregar Producto" : "Actualizar Producto",
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
          ),
        ),
        body: Column(
          children: [
            BodyLoginWidget(id),
          ],
        ),
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget(this.id, {super.key});

  final String? id;

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> with Validation {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormProductBloc>();
    if (widget.id != null) {
      bloc.add(GetProductEvent(widget.id!));
    }
    TextEditingController nameField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController urlField = TextEditingController();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(state.message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ));
            break;
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          nameField.text = state.model.name;
          priceField.text = state.model.price;
          urlField.text = state.model.urlImage;

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    //Load image from URL
                    Image.network(
                      urlField.text,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        Log.e(_tag, 'Error loading image: $error');
                        return Icon(Icons.error, size: 100, color: Colors.red);
                      },
                    ),
                    TextFormField(
                      controller: nameField,
                      onChanged: (value) =>
                          bloc.add(NameChangedEvent(name: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Name:",
                        icon: Icon(Icons.card_giftcard),
                        hintText: "Escribe el nombre del producto",
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      controller: urlField,
                      onChanged: (value) =>
                          bloc.add(UrlImageChangedEvent(urlImage: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Url:",
                        icon: Icon(Icons.image),
                        hintText: "Escribe la url del producto",
                      ),
                    ),
                    SizedBox(height: 32.0),
                    TextFormField(
                      controller: priceField,
                      onChanged: (value) =>
                          bloc.add(PriceChangedEvent(price: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: "Precio:",
                        icon: Icon(Icons.attach_money),
                        hintText: "Escribe el precio del producto",
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                    SizedBox(height: 48.0),
                    FilledButton(
                      onPressed: () => {bloc.add(SubmitEvent())},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(widget.id == null ? "Crear" : "Actualizar",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          // switch (state) {
          //   case DataUpdateState():
          //     print(state.model.email);
          //     break;

          //   default:
          // }
          // return Expanded(
          //   child: Container(
          //     color: Colors.amber,
          //     child: InkWell(child: Text("data"), onTap: () {
          //       bloc.add(EmailChangedEvent(email: "Cambio de email"));
          //     }),
          //   ),
          // );
        },
      ),
    );
  }
}
