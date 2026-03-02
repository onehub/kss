source "https://rubygems.org"

group :test do
  if RUBY_VERSION >= "4.0"
    gem "minitest", "~> 6.0"
  elsif RUBY_VERSION >= "3.4"
    gem "minitest", "~> 5.25"
  else
    gem "minitest", "~> 5.0.4"
  end
  gem "test-unit" unless RUBY_VERSION < "2.0"
end

group :development do
  if RUBY_VERSION < "2.3"
    gem "rake", "~> 12.0"
  else
    gem "rake", "~> 13.0"
  end
end
