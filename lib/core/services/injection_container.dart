import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_apps/src/authentication/data/datasource/auth_remote_sorce.dart';
import 'package:education_apps/src/authentication/data/implements/auth_implementation.dart';
import 'package:education_apps/src/authentication/domain/repos/auth_repository.dart';
import 'package:education_apps/src/authentication/domain/usecases/forgot_password.dart';
import 'package:education_apps/src/authentication/domain/usecases/sign_in.dart';
import 'package:education_apps/src/authentication/domain/usecases/sign_up.dart';
import 'package:education_apps/src/authentication/domain/usecases/update_user.dart';
import 'package:education_apps/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_apps/src/onboarding/data/datasorce/on_boarding_local_source.dart';
import 'package:education_apps/src/onboarding/data/implementations/on_boarding_implementation.dart';
import 'package:education_apps/src/onboarding/domain/repositores/on_boarding_repository.dart';
import 'package:education_apps/src/onboarding/domain/usecases/cache_first_timer.dart';
import 'package:education_apps/src/onboarding/domain/usecases/check_user_first_timer.dart';
import 'package:education_apps/src/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
