import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

const ACCESS_TOKEN_KEY = 'access_token';
const REFRESH_TOKEN_KEY = 'refresh_token';

const emulatorIP = '10.0.2.2:3000';
const simulatorIP = '127.0.0.1:3000';

final SERVER_IP = Platform.isIOS ? simulatorIP : emulatorIP;
