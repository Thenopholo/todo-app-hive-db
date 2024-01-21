import 'package:curso_flutter/utils/app_str.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

String lottieURL = 'assets/lottie/1.json';

/// EMPTY TITLE OR SUBTILTE TEXTFILD WARNING
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'Preencha todos os campos de texto.',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

/// NOTHING WHE USER TRY TI EDIT OR UPDATE TASK
dynamic updateTaskWarnig(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'Adicione uma nova tarefa para atualizar.',
    corner: 20.0,
    duration: 5000,
    padding: const EdgeInsets.all(20),
  );
}

///NO TASK WARNIG DIALOG FOR DELETING
dynamic noTaskWarnig(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message:
        'Nenhuma tarefa para apagar. Tente adicionar uma nova tarefa para apagar.',
    buttonText: 'Entendi!',
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

///DELETE ALL TASKS FROM DB DIALOG
dynamic deleteAllTasks(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message:
        'Tem certeza que deseja apagar todas as tarefas? Essa ação não pode ser desfeita.',
    confirmButtonText: 'Apagar',
    cancelButtonText: 'Cancelar',
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      //NOTE: Vamos usar esse comando para apagar toda a BD  do Hive
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
