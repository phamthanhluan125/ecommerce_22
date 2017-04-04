source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails",        "5.0.1"
gem "puma",         "3.4.0"
gem "sass-rails",   "5.0.6"
gem "uglifier",     "3.0.0"
gem "coffee-rails", "4.2.1"
gem "jquery-rails", "4.1.1"
gem "jbuilder",     "2.4.1"
#Signup-password
gem "bcrypt",         "3.1.11"
#Bootstrap
gem "bootstrap-sass", "3.3.6"
#Rails config
gem "config"
gem "pry"
gem "inline_svg"
#updateimage
gem "carrierwave",     "0.11.2"
gem "mini_magick",     "4.5.1"
gem "fog",             "1.38.0"
gem "will_paginate",   "3.1.0"
gem "bootstrap-will_paginate", "0.0.10"
gem "roo"
gem "roo-xls"
#ck-editor
gem "ckeditor"

group :development, :test do
  gem "sqlite3", "1.3.12"
  gem "byebug",  "9.0.0", platform: :mri
end

group :development do
  gem "web-console",           "3.1.1"
  gem "listen",                "3.0.8"
  gem "spring",                "1.7.2"
  gem "spring-watcher-listen", "2.0.0"
end

group :production do
  gem "pg", "0.18.4"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
