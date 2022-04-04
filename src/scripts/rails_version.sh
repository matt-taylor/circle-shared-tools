
gemlock_rails=$(cat Gemfile.lock | grep "^  rails (")

if [[ "$gemlock_rails" == *"$EXPECTED_RAILS_VERSION"* ]]; then
  echo "Gemfile.lock Rails version matches the expected rails version"
else
  echo "Yikes! found rails [$gemlock_rails]. Expected $EXPECTED_RAILS_VERSION. Something went wrong. Exiting"
  exit 1
fi
