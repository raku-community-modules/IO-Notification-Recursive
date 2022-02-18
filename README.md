[![Actions Status](https://github.com/raku-community-modules/IO-Notification-Recursive/workflows/test/badge.svg)](https://github.com/raku-community-modules/IO-Notification-Recursive/actions)

NAME
====

IO::Notification::Recursive - Recursively watch a directory and any subdirectories

SYNOPSIS
========

```raku
use IO::Notification::Recursive;

use IO::Notification::Recursive;

my $supply = watch-recursive(".");

# mention any changes on any files in the current directory and any subdirectories.
$supply.tap({ .say; });

# Also watch for changes in any newly created subdirectories
my $supply = watch-recursive(".", :update);
```

DESCRIPTION
===========

Raku comes with a way to watch a file or directory for changes called `IO::Notification.watch-path` (or `IO::Path.watch`). As files are changed or created or removed from a directory you are watching, these changes are registered on the `Supply` created by `.watch-path` (or `.watch`.

However, if any files are changed or created or removed from any subdirectories, those do not generate changes on the Supply. This module provides a `watch-recursive()` subroutine that will generate changes for a directory and any subdirectories.

By default, if the directory you are watching has subdirectories created while you are watching it, these new directories are **not** added to the list of watched directories. If you pass the `:update` parameter, newly created subdirectories within any directories you are currently watching will also be watched for changes.

AUTHOR
======

Jonathan Scott Duff

Source can be located at: https://github.com/raku-community-modules/IO-Notification-Recursive . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

