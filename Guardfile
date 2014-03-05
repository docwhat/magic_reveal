guard(
  :rspec,
  cmd: 'bundle exec rspec --color --order default --format doc',
  failed_mode: :none,
  all_on_start: true,
  all_after_pass: true,
  run_all: { cmd: 'bundle exec rspec --color --order random --format progress'  }
) do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
  watch(%r{^spec/integration/.+_spec\.rb$}) { 'spec' }
end
