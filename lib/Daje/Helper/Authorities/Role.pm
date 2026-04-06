package Daje::Helper::Authorities::Role;
use Mojo::Base -base, -signatures, -async_await;
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

has 'db';

async sub load_authorities_role_full_p($self, $companies_fkey, $users_fkey) {

    my $stmt = qq{
        SELECT json_build_object(
            'role', name,
            'plugins', (SELECT (json_agg(json_build_object(
                'plugin', name,
                'functions', (SELECT (json_agg(json_build_object(
                    'function', name,
                    'permissions', (SELECT (json_agg(json_build_object(
                        'permission', permission
                    )))
                        FROM  authorities_function_plugin_role_permission, authorities_permissions
                            WHERE authorities_function_fkey = authorities_function_pkey
                                AND authorities_permissions_fkey = authorities_permissions_pkey
                                    AND authorities_role_fkey = authorities_role_pkey
                    )
                )))
                FROM authorities_function_plugin_role, authorities_function
                    WHERE authorities_function_plugin_role.authorities_plugin_fkey = authorities_plugin_pkey
                        AND authorities_function_fkey = authorities_function_pkey AND authorities_role_fkey = authorities_role_pkey)
            )))
            FROM authorities_plugin_role, authorities_plugin
                WHERE authorities_plugin_fkey = authorities_plugin_pkey AND authorities_role_fkey = authorities_role_pkey
            )
        ) FROM authorities_role WHERE authorities_role_pkey = (SELECT authorities_role_fkey
                                                                FROM companies_users
                                                                    WHERE companies_companies_fkey = ?
                                                                        AND users_users_fkey = ? )
    };

    my $load = $self->db->query($stmt, $companies_fkey, $users_fkey);
    my $result->{data} = {};
    $result->{data} = $load->hash if $load and $load->rows > 0;
    $result->{result} = 1;
    return $result;
}
1;