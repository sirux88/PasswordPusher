# Load the Rails application.
require_relative "application"
require 'git-version-bump'

# Initialize the Rails application.
Rails.application.initialize!

$VERSION = GVB.version