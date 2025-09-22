import 'package:flutter/material.dart';
import 'package:minisocialfeedapp/utils/constants.dart';
import 'package:minisocialfeedapp/widgets/dotted_container.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/create_post_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../utils/utils.dart';
import '../../widgets/image_preview.dart';
import 'hashtag_input.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  List<String> _hashtags = [];
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(() {
      if (mounted) {
        setState(() {
          _imageUrl = _imageUrlController.text.trim();
        });
      }
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final createPostProvider = Provider.of<CreatePostProvider>(
        context,
        listen: false,
      );

      if (authProvider.user != null) {
        final success = await createPostProvider.createPost(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          imageUrl: _imageUrlController.text.trim(),
          authorId: authProvider.user!.uid,
          authorName: authProvider.userModel?.displayName ?? 'Anonymous',
          hashtags: _hashtags,
        );

        if (mounted) {
          if (success) {
            showSnackBar(context, 'Post created successfully!');
            Navigator.pop(context);
          } else {
            showSnackBar(
              context,
              createPostProvider.errorMessage ?? 'Failed to create post.',
              isError: true,
            );
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  bool fieldImageUrl = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title Field
                    CustomTextField(
                      controller: _titleController,
                      labelText: 'Title',
                      hintText: 'Enter post title',
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a title'
                          : null,
                    ),
                    kSizedBoxH16,

                    // Description Field
                    CustomTextField(
                      controller: _descriptionController,
                      labelText: 'Description',

                      hintText: 'Enter post description',
                      minLines: 4,
                      maxLines: 7,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter a description'
                          : null,
                    ),
                    kSizedBoxH16,

                    // Image Preview & URL Field
                    DottedBorderWidget(
                      height: _imageUrl.isEmpty
                          ? MediaQuery.sizeOf(context).width * 0.6
                          : MediaQuery.sizeOf(context).width * 0.8,

                      borderRadius: BorderRadius.circular(12),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (_imageUrl.isNotEmpty)
                              ImagePreview(imageUrl: _imageUrl),
                            if (_imageUrl.isNotEmpty) kSizedBoxH16,
                            if (_imageUrl.isEmpty) ...[
                              Text(
                                'Upload Image',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Drag and drop or click to upload',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.3,
                                    36,
                                  ),
                                  maximumSize: Size(
                                    MediaQuery.of(context).size.width * 0.3,
                                    36,
                                  ),
                                  backgroundColor: kInputFieldColor,
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    fieldImageUrl = !fieldImageUrl;
                                  });
                                },
                                child: Text("Upload"),
                              ),
                            ],
                            if (fieldImageUrl)
                              CustomTextField(
                                controller: _imageUrlController,
                                labelText: 'Image URL',
                                keyboardType: TextInputType.url,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an image URL';
                                  }
                                  if (!Uri.parse(value).isAbsolute) {
                                    return 'Please enter a valid URL';
                                  }
                                  return null;
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    kSizedBoxH16,
                    // Hashtag Input
                    HashtagInput(
                      onHashtagsChanged: (hashtags) {
                        setState(() {
                          _hashtags = hashtags;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Submit Button Area
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<CreatePostProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: _submit,
                    child: provider.isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : const Text('Publish'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
