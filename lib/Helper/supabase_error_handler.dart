import 'package:get/get.dart';

String supabaseErrorHandler(dynamic error) {
  if (error == null) return 'An unknown error occurred.';

  String errorMessage = 'An error occurred. Please try again.';
  String errorString = error.toString();

  // Handle unique constraint violations (duplicate entries)
  if (errorString.contains('duplicate key value violates unique constraint')) {
    RegExp duplicateKeyRegex = RegExp(r'unique constraint "(\w+)"');
    Match? match = duplicateKeyRegex.firstMatch(errorString);

    if (match != null) {
      String constraint = match.group(1) ?? '';
      String fieldName =
      constraint.replaceAll('users_', '').replaceAll('_key', '');
      errorMessage =
      '${fieldName.capitalize!} already exists. Please choose a different one.';
    }
  }

  // Handle not-null constraint violations (missing required fields)
  else if (errorString.contains('not-null constraint')) {
    RegExp nullConstraintRegex = RegExp(r'column "(\w+)" of relation');
    Match? match = nullConstraintRegex.firstMatch(errorString);

    if (match != null) {
      String column = match.group(1) ?? 'A required field';
      errorMessage = '$column is required. Please fill it in.';
    }
  }

  // Handle other common Supabase errors
  else if (errorString.contains('permission denied')) {
    errorMessage = 'You do not have permission to perform this action.';
  } else if (errorString.contains('23505')) {
    errorMessage = 'Duplicate entry detected. Please use a different value.';
  } else if (errorString.contains('23502')) {
    errorMessage = 'A required field is missing. Please check your input.';
  } else if (errorString.contains('23503')) {
    errorMessage = 'Invalid reference. Please check related fields.';
  }

  return errorMessage;
}
