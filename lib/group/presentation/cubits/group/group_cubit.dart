import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobihub/group/domain/entities/group_entity.dart';
import 'package:hobihub/group/domain/usecases/get_group_usecase.dart';
import 'dart:io';
part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetGroupsUseCase getGroupsUseCase;

  GroupCubit({
    required this.getGroupsUseCase,
  }) : super(GroupInitial());

  Future<void> getGroups() async {
    emit(GroupLoading());
    try {
      final streamResponse = getGroupsUseCase.call(const GroupEntity());
      streamResponse.listen((group) {
        emit(GroupLoaded(group: group));
      });
    } on SocketException catch (_) {
      emit(GroupFailure());
    } catch (_) {
      emit(GroupFailure());
    }
  }
}
