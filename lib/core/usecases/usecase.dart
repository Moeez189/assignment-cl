/// Base class for use cases
/// [Type] is the return type
/// [Params] is the input parameters type
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Use case that doesn't require any parameters
abstract class UseCaseNoParams<Type> {
  Future<Type> call();
}
