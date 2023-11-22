class SignUpWithEmailPasswordFailure {
  final String message;

  SignUpWithEmailPasswordFailure([this.message = 'An unknown error occurred']);

  factory SignUpWithEmailPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return SignUpWithEmailPasswordFailure('Арай суга нууц үг байна аа.');
      case 'invalid-email':
        return SignUpWithEmailPasswordFailure('Имейлээ дахиад шалгаарай, ийм имейл хорвоо дэлхий дээр байхгүй байна даа.');
      case 'email-already-in-use':
        return SignUpWithEmailPasswordFailure('Энэ имейл бүртгэгдчихжээ хө.');
      case 'operation-not-allowed':
        return SignUpWithEmailPasswordFailure('Өө нэг юм болдоггүй ээ, тусламж үзүүлэх хэсэгт хандаарай.');
      case 'user-disabled':
        return SignUpWithEmailPasswordFailure('Энэ хэрэглэгч нэвтрэх боломжгүй болсон байна аа, тусламж үзүүлэх хэсэгт хандаарай.');
      default:
        return SignUpWithEmailPasswordFailure();
    }
  }
}
