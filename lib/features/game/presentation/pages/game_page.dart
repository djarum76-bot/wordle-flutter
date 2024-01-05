import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:wordle/features/game/presentation/blocs/game/game_bloc.dart';
import 'package:wordle/features/game/presentation/widgets/game_history.dart';
import 'package:wordle/features/game/presentation/widgets/game_text_field.dart';
import 'package:wordle/injector.dart';
import 'package:wordle/shared/extensions/focus_node_extension.dart';
import 'package:wordle/shared/extensions/media_query_extension.dart';
import 'package:wordle/shared/extensions/string_extension.dart';
import 'package:wordle/shared/extensions/text_editing_controller_extension.dart';
import 'package:wordle/shared/widgets/app_button.dart';
import 'package:wordle/shared/widgets/finish_dialog.dart';
import 'package:wordle/themes/app_text_style.dart';

class GamePage extends StatefulWidget{
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(5, (index) => FocusNode());
    _controllers = List.generate(5, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: injector<GameBloc>()..add(GameInitialled()),
      child: Scaffold(
        body: _gameBody(context),
      ),
    );
  }

  Widget _gameBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state){
            if (state.status == GameStatus.finish) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => FinishDialog(
                  alertTitle: state.alertTitle,
                  alertMessage: state.alertMessage,
                  onTap: (){
                    injector<GameBloc>().add(GameRestarted());
                    Navigator.pop(context);
                  }
                )
              );
            }
          },
          builder: (context, state){
            if (state.status == GameStatus.loading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wordle",
                    style: AppTypography.heading1,
                  ),
                  Gap(10.h),
                  ...state.answers.map((answer) => GameHistory(userAnswer: answer.selection, realAnswer: state.answer,)).toList(),
                  Gap(2.h),
                  Text(
                    "Answer",
                    style: AppTypography.subHeading1,
                  ),
                  GameTextField(focusNodes: _focusNodes, controllers: _controllers),
                  Gap(1.h),
                  AppButton(
                    onTap: () {
                      if (_controllers.isValid && _controllers.value.isValidEnglish) {
                        injector<GameBloc>().add(GameSubmitted(_controllers.value));
                      }

                      _controllers.clearField();
                      _focusNodes.removeFocus();
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}