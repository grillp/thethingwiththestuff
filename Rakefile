task :default => [:test]

task :travis_ci => [:test, :run]

task :test do
  sh 'bundle exec rspec spec'
end

task :run do
	sh 'ruby runme.rb'
end