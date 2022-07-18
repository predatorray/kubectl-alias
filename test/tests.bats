#!/usr/bin/env bats

original_path=

function setup() {
    rm -f VERSION
    rm -rf alias
    mkdir -p alias
    original_path="$PATH"
    export PATH="$(pwd)/test/mockbin:$PATH"
}

function teardown() {
    rm -rf alias
    export PATH="${original_path}"
}

@test "create_an_simple_alias" {
    bin/kubectl-alias v version
    [ -x alias/kubectl-v ]
    local cmd_output=$(alias/kubectl-v)
    [ "${cmd_output}" = 'version' ]
}

@test "create_an_alias_with_arguments" {
    bin/kubectl-alias f foobar
    [ -x alias/kubectl-f ]
    local cmd_output=$(alias/kubectl-f 1 2)
    [ "${cmd_output}" = 'foobar 1 2' ]
}

@test "create_an_alias_no_args" {
    bin/kubectl-alias --no-args f foobar
    [ -x alias/kubectl-f ]
    local cmd_output=$(alias/kubectl-f 1 2)
    [ "${cmd_output}" = 'foobar' ]
}

@test "create_an_alias_with_offset_parameter_and_no_arg" {
    bin/kubectl-alias --no-args f '$1 foo $2 bar'
    [ -x alias/kubectl-f ]
    local cmd_output=$(alias/kubectl-f 1 2)
    [ "${cmd_output}" = '1 foo 2 bar' ]
}

@test "create_an_alias_with_offset_parameter_without_no_arg" {
    bin/kubectl-alias f '$1 foo $2 bar'
    [ -x alias/kubectl-f ]
    local cmd_output=$(alias/kubectl-f 1 2)
    [ "${cmd_output}" = '1 foo 2 bar 1 2' ]
}

@test "create_an_alias_with_invalid_name_number" {
    local exit_code
    bin/kubectl-alias 123 'yes' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "create_an_alias_with_invalid_name_underscore" {
    local exit_code
    bin/kubectl-alias a_b 'yes' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "create_an_alias_with_invalid_name_question_mark" {
    local exit_code
    bin/kubectl-alias 'a?' 'yes' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "create_an_alias_with_invalid_name_leading_number" {
    local exit_code
    bin/kubectl-alias '1a' 'yes' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "create_an_alias_with_reserved_command_version" {
    local exit_code
    bin/kubectl-alias 'version' 'yes' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "create_an_alias_with_reserved_command_get" {
    local exit_code
    bin/kubectl-alias 'get' 'yes' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "delete_an_alias" {
    bin/kubectl-alias v version
    [ -x alias/kubectl-v ]
    bin/kubectl-alias --delete v
    [ ! -f alias/kubectl-v ]
}

@test "delete_an_alias_that_does_not_exist" {
    bin/kubectl-alias --delete na || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "list_all_aliaes" {
    bin/kubectl-alias v1 version
    bin/kubectl-alias v2 version
    
    local list_output=$(bin/kubectl-alias --list)
    [ "${list_output}" = $'v1 = version\nv2 = version' ]
}

@test "version" {
    local version_output=$(bin/kubectl-alias --version)
    [ "${version_output}" = 'unknown' ]
}

@test "help" {
    local version_output=$(bin/kubectl-alias --help)
    [ ! -z "${version_output}" ]
}

@test "prefix" {
    local prefix_output=$(bin/kubectl-alias --prefix)
    [ "${prefix_output}" = "$(pwd)/alias" ]
}

@test "list_and_delete_at_same_time" {
    local exit_code
    bin/kubectl-alias '--list' '--delete' foobar || exit_code="$?"
    [ "${exit_code}" = 1 ]
}

@test "list_and_delete_and_prefix_at_same_time" {
    local exit_code
    bin/kubectl-alias '--list' '--delete' foobar '--prefix' || exit_code="$?"
    [ "${exit_code}" = 1 ]
}
