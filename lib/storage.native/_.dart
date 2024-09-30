library storage__native;

//

import "package:base/base/_.dart";
import "../storage/_.dart";
import "../foreign.interface/_.dart";

import "dart:ffi" as ffi;

import "package:stdlibc/stdlibc.dart" //
    show
        fstat,
        Stat;

//

part "file/linux.dart";
