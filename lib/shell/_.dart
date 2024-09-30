library shell;

//

import "package:base/base/_.dart";

import "dart:io" as io;

//

const //
    io__shell__static__string__environment__variable__id_ = "SHELL";

string? io__shell() => //
    io.Platform.environment[io__shell__static__string__environment__variable__id_];

string io__shell__process__run(
  final string command,
) {
  final shell = io__shell();

  if (shell ==  null) //
    throw "shell ==  null";

  final result = io.Process.runSync(
    shell,
    <string>["-c", command],
  );

  if (result.exitCode != 0) //
    throw "${result.exitCode}(exitCode), is NOT 0; stderr: \"${result.stderr}\"";

  final stdout = result.stdout;

  if (stdout is! string) //
    throw "\"$stdout\"(stdout) is NOT `string`";

  return stdout;
}
