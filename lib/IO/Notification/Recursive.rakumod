use File::Find;

my sub find-dirs(IO::Path:D $dir) {
    slip $dir.IO, slip find :$dir, :type<dir>
}

sub watch-recursive(IO(Cool) $start, Bool :$update) is export {
    supply {
        my sub watch-it(IO::Path:D $io) {
            whenever $io.watch -> $e {
                if $update {
                    if $e.event ~~ FileRenamed && $e.path.d {
                        watch-it($_) for find-dirs $e.path;
                    }
                }
                emit $e;
            }
        }
        watch-it($_) for find-dirs $start;
    }
}

=begin pod

=head1 NAME

IO::Notification::Recursive - Recursively watch a directory and any subdirectories

=head1 SYNOPSIS

=begin code :lang<raku>

use IO::Notification::Recursive;

use IO::Notification::Recursive;

my $supply = watch-recursive(".");

# mention any changes on any files in the current directory and any subdirectories.
$supply.tap({ .say; });

# Also watch for changes in any newly created subdirectories
my $supply = watch-recursive(".", :update);

=end code

=head1 DESCRIPTION

Raku comes with a way to watch a file or directory for changes called
C<IO::Notification.watch-path> (or C<IO::Path.watch>).  As files are
changed or created or removed from a directory you are watching, these
changes are registered on the C<Supply> created by C<.watch-path> (or
C<.watch>.

However, if any files are changed or created or removed from any
subdirectories, those do not generate changes on the Supply.  This
module provides a C<watch-recursive()> subroutine that will generate
changes for a directory and any subdirectories.

By default, if the directory you are watching has subdirectories created
while you are watching it, these new directories are B<not> added to the
list of watched directories.  If you pass the C<:update> parameter, newly
created subdirectories within any directories you are currently watching
will also be watched for changes.

=head1 AUTHOR

Jonathan Scott Duff

Source can be located at: https://github.com/raku-community-modules/IO-Notification-Recursive .
Comments and Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 Jonathan Scott Duff

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
