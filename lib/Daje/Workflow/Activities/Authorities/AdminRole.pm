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


sub create_admin($self) {
    $self->model->insert_history(
        "Admin role for new client",
        "Daje::Workflow::Activities::Authorities::AdminRole::create_admin",
        1
    );

}
1;