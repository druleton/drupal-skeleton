################################################################################
# Hook information for the Install script.
################################################################################

# Common hook information.
hook_info_run_load "common.sh"

# Script specific information.
hook_info_run_load "script_before.sh"
hook_info_run_load "init_composer.sh"
hook_info_run_load "init_custom_commands.sh"
hook_info_run_load "script_after.sh"
