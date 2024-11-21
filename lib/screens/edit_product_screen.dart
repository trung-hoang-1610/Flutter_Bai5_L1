import 'package:flutter/material.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:shopping_app/blocs/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedProduct = Product(
                      id: widget.product.id, // Giữ nguyên ID sản phẩm
                      name: _nameController.text,
                      price: double.parse(_priceController.text),
                      description: _descriptionController.text,
                      imageUrl: widget.product.imageUrl, // Giữ nguyên URL ảnh
                    );

                    // Gửi sự kiện để cập nhật sản phẩm
                    BlocProvider.of<ProductBloc>(context)
                        .add(UpdateProduct(product: updatedProduct));

                    // Quay lại màn hình trước
                    Navigator.pop(context);
                  }
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
