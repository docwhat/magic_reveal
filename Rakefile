require 'magic_reveal/creator'

task :update do
  pwd = File.dirname(__FILE__)
  %w{lib css js plugin}.each { |dir| rm_rf dir }
  sh %Q{ git show origin/master:README.md > slides.md }
  MagicReveal::Creator.new(pwd).update_project(pwd)
  sh %Q( magic-reveal static )
end
