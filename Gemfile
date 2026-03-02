source "https://rubygems.org"

group :test do
  gem "minitest", "~> 4.0"
  gem "test-unit" unless RUBY_VERSION < "2.0"
end

group :development do
  gem "mg", ">= 0.0.8"
  if RUBY_VERSION < "2.3"
    gem "rake", "~> 12.0"
  else
    gem "rake", "~> 13.0"
  end
  gem "rubyforge", ">= 2.0.3"
end
