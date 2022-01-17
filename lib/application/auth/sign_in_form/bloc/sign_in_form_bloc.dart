import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/domain/auth/auth_failure.dart';
import 'package:notes_app/infrastructure/auth/firebase_auth_facade.dart';
import '../../../../domain/auth/value_objects.dart';
import '../../../../domain/auth/i_auth_facade.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  // SignInFormState get initialState => SignInFormState.initial();
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    // on<SignInFormEvent>((event, emit) {

    // });

    // on email changed
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        emailAddress: EmailAddress(event.emailStr),
        authFailureOrSuccessOption: none(),
      ));
    });
    // on password changed
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: Password(event.passwordStr),
        authFailureOrSuccessOption: none(),
      ));
    });

    // Register email n password
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      Either<AuthFailure, Unit>? failureOrSuccess;

      final isEmailValid = state.emailAddress.isValid;
      final isPasswordValid = state.password.isValid;

      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ));

        failureOrSuccess = await _authFacade.registerWithEmailAndPassword(
            emailAddress: state.emailAddress, password: state.password);
      }
      emit(state.copyWith(
        isSubmitting: false,
        showErrorMsgs: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
// SignIn with email n password
    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      Either<AuthFailure, Unit>? failureOrSuccess;

      final isEmailValid = state.emailAddress.isValid;
      final isPasswordValid = state.password.isValid;

      if (isEmailValid && isPasswordValid) {
        emit(state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ));

        failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
            emailAddress: state.emailAddress, password: state.password);
      }
      emit(state.copyWith(
        isSubmitting: false,
        showErrorMsgs: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });

    //sign in with google
    on<SignInWithGooglePressed>((event, emit) async {
      emit(state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none()));
      final failureOrSuccess = await _authFacade.singInWithGoogle();
      emit(state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess)));
    });
  }

// refactoring
// Stream<SignInFormState> _performActionOnAuthFacadeEmailAndPassword(
// Future<Either<AuthFailure, Unit>> Function({required EmailAddress emailAddress, required Password password}) forwardedCall
// )async*{

// }

//end
}
