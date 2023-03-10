import 'package:tieup_company/core/entities/login_params.dart';
import 'package:tieup_company/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tieup_company/core/use_cases/use_case.dart';
import 'package:tieup_company/features/authentication/domain/repositories/authentication_repositry.dart';


class LoginUser extends UseCase<bool,LoginParams>{
  final AuthenticationRepository _authenticationRepository;
  LoginUser(this._authenticationRepository);

  @override
  Future<Either<Failure, bool>> call(LoginParams params) async =>
      _authenticationRepository.loginUser(params.email,params.password);
  }



