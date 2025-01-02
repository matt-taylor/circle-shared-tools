
CURRENT_RAILS_VERSION=$(bundle exec gem list rails | grep -i "^rails (" | tr -cd "0-9.")
COMMAND="require \"bundler\";"\
"dependency = Gem::Dependency.new(\"rails\", Gem::Requirement.new([$EXPECTED_RAILS_VERSION]), :runtime);"\
"puts dependency.match?(\"rails\", $CURRENT_RAILS_VERSION]) ==  nil"

dependency_result=$(ruby -e "$COMMAND")

if [[ "$dependency_result" == "false" ]]; then
  echo "Gemfile.lock Rails version matches the expected rails version"
else
  echo "Yikes! found rails [$CURRENT_RAILS_VERSION]. Expected $EXPECTED_RAILS_VERSION. Something went wrong. Exiting"
  exit 1
fi
