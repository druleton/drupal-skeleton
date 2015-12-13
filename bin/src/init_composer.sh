################################################################################
# Functionality to install or update composer locally.
################################################################################


##
# Install (download) or (self-)update a local composer instance.
#
# This script will trigger 2 "hooks" in the config/<script-name>/ directory:
# - init_composer_before : Scripts that should run before composer is
#   installed/updated.
# - init_composer_after  : Scripts that should run after composer is
#   installed/updated.
#
# The hooks will be called without and with environment suffix.
##
function init_composer_run {
  # Hook before install/update composer.
  hook_invoke "init_composer_before"

  # Disable composer x-debug warnings
  COMPOSER_DISABLE_XDEBUG_WARN=1

  if [ -f "$DIR_BIN/composer" ]; then
    init_composer_update
    echo
    init_composer_init
    echo
    init_composer_update_packages
    echo
  else
    init_composer_install
    echo
    init_composer_init
    echo
  fi

  # Hook after install/update composer.
  hook_invoke "init_composer_after"
}

##
# Install composer by downloading phar file locally.
##
function init_composer_install {
  markup_h1 "Install composer."
  curl -sS https://getcomposer.org/installer \
    | php -- --install-dir="$DIR_BIN" --filename=composer
}

##
# Update composer.
##
function init_composer_update {
  markup_h1 "Update composer."
  composer_skeleton_run self-update
}

##
# Initiate the composer environment.
##
function init_composer_init {
  markup_h1 "Initiate composer."

  if [ -f "$DIR_BIN/composer.json" ]; then
    message_success "Composer was already initiated."
  else
    composer_skeleton_run -n init \
      --name="drupal-skeleton/bin" \
      --description="PHP packages needed by the skeleton." \
      --author="zero2one <zero2one@serial-graphics.be>" \
      --homepage="https://github.com/zero2one/drupal-skeleton" \
      --license="MIT" \
      --type="library"
    message_success "Composer is initiated"
  fi
}

##
# Update the composer packages.
##
function init_composer_update_packages {
  markup_h1 "Update installed composer packages"
  composer_skeleton_run update
}