import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hobihub/group/domain/entities/text_message_entity.dart';
import 'package:hobihub/group/domain/usecases/get_message_usecase.dart';
import 'package:hobihub/group/domain/usecases/send_text_message_usecase.dart';


part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessageUseCase getMessageUseCase;

  ChatCubit(
      {required this.sendTextMessageUseCase, required this.getMessageUseCase})
      : super(ChatInitial());
  
  Future<void> getMessages ({required String channelId}) async{
    emit(ChatLoading());
    try {
      final streamResponse = getMessageUseCase.call(channelId);
      streamResponse.listen((messages) {
        emit(ChatLoaded(messages: messages));
      });
    }on SocketException catch(e){
      print('SocketException during getMessages: $e');
      emit(ChatFailure());
    }catch (e) {
      print('Error during getMessages: $e');
      emit(ChatFailure());
    }
  }

  Future<void> sendTextMessage ({required TextMessageEntity textMessageEntity, required String channelId}) async{
    try {
      await sendTextMessageUseCase.call(textMessageEntity, channelId);
    }on SocketException catch(e) {
      print('SocketException during sendTextMessages: $e');
      emit(ChatFailure());
    }catch (e) {
      print('Error during sendTextMessage: $e');
      emit(ChatFailure());
    }
  }
}
