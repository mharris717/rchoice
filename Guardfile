# A sample Guardfile
# More info at https://github.com/guard/guard#readme




guard 'rspec', :cli => "--drb" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})   { "spec" } # { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.treetop$})   { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }
end




guard 'spork' do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
end
