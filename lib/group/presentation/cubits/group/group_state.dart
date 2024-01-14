part of 'group_cubit.dart';

abstract class GroupState extends Equatable {
  const GroupState();
}

class GroupInitial extends GroupState {
  @override
  List<Object> get props => [];
}

class GroupLoaded extends GroupState {
  final List<GroupEntity> group;

  const GroupLoaded({required this.group});

  @override
  List<Object> get props => [group];
}

class GroupLoading extends GroupState {
  @override
  List<Object> get props => [];
}

class GroupFailure extends GroupState {
  @override
  List<Object> get props => [];
}
