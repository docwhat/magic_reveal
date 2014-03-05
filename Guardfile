group :red_green_refactor, halt_on_fail: true do
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

  guard :rubocop, cli: 'lib spec -D', all_on_start: true do
    watch(%r{^(lib|spec)/.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
