use strict;
use warnings;

package Test::WithNetwork;

# ABSTRACT: Indicate a test requires Network resources to work.

=head1 SYNOPSIS

=head2 In Tests

=head3 Per-File Filter

  use Test::More;
  use Test::WithNetwork 'Dist-Foo-Bar' => [qw( dns tcp ssl )]; # exit skip if policy doesn't indicate all are permitted.

=head3 Localised Filter

  use Test::More;
  use Test::WithNetwork 'Dist-Foo-Bar';

  with_network [qw( dns tcp )] => sub {
    # Tests that require network resources

  };
  # Non-network depedndent tests

=head3 Conditional Checking

  use Test::More;
  use Test::WithNetwork 'Dist-Foo-Bar';

  if ( can_network(qw( dns tcp )) ) {
    # Tests that require network resources

  };
  # Non-network depedndent tests

=cut

=head2 User Side

C<~/.perl_test_withnetwork.ini>

  -permission_denied = silent
  ; -permission_denied = warn
  ; -permission_denied = log
  ; -log_file = /tmp/test-with-network.log
  dns = y
  tcp = n
  ssl = n

  # Special grants for Dist-Foo-Bar
  [Dist-Foo-Bar]
  # dns inherited from global
  tcp = y

=head2 Standard Test output

  t/01-somenetworkthing: Test::WithNetwork was not granted Dist-Foo-Bar/ssl permission. Skipped.
  t/02-somenetworkthing: Test::WithNetwork was not granted Dist-Foo-Bar/ssl permission. Skipped some tests.

=cut

1;
