package Daje::Workflow::Activities::Authorities::AdminRole;
use Mojo::Base 'Daje::Workflow::Common::Activity::Base', -base, -signatures;
use v5.42;

# NAME
# ====
#
# Daje::Workflow::Activities::Authorities::AdminRole - Daje helper,
# creates a new admin role and attach it to user and company
#
# SYNOPSIS
# ========
#
#
# DESCRIPTION
# ===========
#
# Daje::Workflow::Activities::Authorities::AdminRole a helper clas
#
# METHODS
# =======
#
#
#
#
# SEE ALSO
# ========
#
# Mojolicious, Mojolicious::Guides, https://mojolicious.org.
#
# LICENSE
# =======
#
# Copyright (C) janeskil1525.
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# AUTHOR
# ======
#
# janeskil1525 E<lt>janeskil1525@gmail.com
#

use Daje::Database::Model::AuthoritiesRole;
use Daje::Database::View::vAuthoritiesPluginList;

sub create_admin($self) {
    $self->model->insert_history(
        "Admin role for new client",
        "Daje::Workflow::Activities::Authorities::AdminRole::create_admin",
        1
    );
    my $data = $self->context->{context}->{payload};
    $data->{workflow_fkey} = $self->context->{context}->{workflow}->{workflow_fkey};

    my $authorities_role_pkey = Daje::Database::Model::AuthoritiesRole->new(
        db => $self->db
    )->insert({
        name                      => 'Administrator',
        authorities_workflow_fkey => $data->{workflow_fkey},
        standard                  => 1
    });

    my $plugins = Daje::Database::View::vAuthoritiesPluginList->new(
        db => $self->db
    )->load_all_authorities_plugin();


}
1;