use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use v5.42;
use Moo;
use MooX::Options;
use Cwd;
use Mojo::Pg;

use feature 'say';
use feature 'signatures';
use Daje::Workflow::Activities::Authorities::AdminRole;;
use Daje::Workflow::Errors::Error;
use Daje::Workflow::Database::Model;
use namespace::clean -except => [qw/_options_data _options_config/];

sub create_admin_role() {

    my $pg = Mojo::Pg->new()->dsn(
        "dbi:Pg:dbname=sentinel;host=192.168.1.124;port=5432;user=sentinel;password=PV58nova64"
    );

    try {
        my $model = Daje::Workflow::Database::Model->new(db => $pg->db);

        my $context->{context}->{payload}->{tools_projects_fkey} = 1;
        my $role = Daje::Workflow::Activities::Authorities::AdminRole->new(
            db      => $pg->db,
            context => $context,
            model   => $model,
            error   => Daje::Workflow::Errors::Error->new(),
        );
        $role->create_admin();
    } catch ($e) {
        say $e;
    };

}

create_admin_role();


