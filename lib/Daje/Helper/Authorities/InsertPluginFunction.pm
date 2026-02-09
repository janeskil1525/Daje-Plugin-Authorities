package Daje::Helper::Authorities::InsertPluginFunction;
use Mojo::Base -base, -signatures;
use v5.42;

# NAME
# ====
#
# Daje::Helper::Authorities::InsertPluginFunction - Daje helper
#
# SYNOPSIS
# ========
#
#
# DESCRIPTION
# ===========
#
# Daje::Helper::Authorities::InsertPluginFunction a helper clas
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

sub process($self, $app, $plugin, $functions) {

    $app->pg->db->query("INSERT INTO authorities_plugin (name) VALUES (?) ON CONFLICT(name) DO NOTHING",($plugin));

    my $stmt = qq{
                    INSERT INTO authorities_function (name, authorities_plugin_fkey)
                        VALUES (?,( SELECT authorities_plugin_pkey FROM authorities_plugin WHERE name = ? ))
                    ON CONFLICT (name) DO NOTHING
    };

    my $length = scalar @{$functions};
    for (my $i = 0; $i < $length; $i++) {
        $app->pg->db->query($stmt,(@{$functions}[$i], $plugin));
    }
}

1;