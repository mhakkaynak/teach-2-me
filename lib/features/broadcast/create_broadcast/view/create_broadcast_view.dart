import 'package:flutter/material.dart';

import '../../../../core/constants/navigation/navigation_constant.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/init/navigation/navigation_manager.dart';
import '../../../../products/firebase/firestore/firestore_service.dart';
import '../../../../products/models/lesson_model.dart';
import '../../../../products/widgets/text_field/custom_text_field.dart';

class CreateBroadcastView extends StatefulWidget {
  const CreateBroadcastView({Key? key}) : super(key: key);

  @override
  State<CreateBroadcastView> createState() => _CreateBroadcastViewState();
}

class _CreateBroadcastViewState extends State<CreateBroadcastView> {
  final String _appBarText = 'Create broadcast';
  final String _buttonText = 'Start live stream';
  final TextEditingController _lessonNameTextController =
      TextEditingController();

  final TextEditingController _subjectTextController = TextEditingController();
  final String _textField1 = 'Lesson name';
  final String _textField2 = 'SubjectName';

  FloatingActionButton _buildFab() {
    return FloatingActionButton.extended(
      onPressed: _onPressed,
      label: Text(_buttonText),
    );
  }

  CustomTextField _buildTextField(
      BuildContext context, TextEditingController controller, String text) {
    return CustomTextField(
      controller: controller,
      context: context,
      textAlign: TextAlign.center,
      maxLines: 1,
      hintText: text,
    );
  }

  void _onPressed() {
    if (_lessonNameTextController.text.isNotEmpty &&
        _subjectTextController.text.isNotEmpty) {
      FirestoreService.instance?.addLesson(LessonModel(
        name: _lessonNameTextController.text,
        subject: _subjectTextController.text,
      ));
      _lessonNameTextController.clear();
      _subjectTextController.clear();
      NavigationManager.instance
          ?.navigationToPage(NavigationConstant.broadcast, args: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarText),
        centerTitle: true,
      ),
      body: Padding(
        padding: context.paddingLowSymetric,
        child: Column(
          children: [
            _buildTextField(context, _lessonNameTextController, _textField1),
            const SizedBox(
              height: 64,
            ),
            _buildTextField(context, _subjectTextController, _textField2),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
