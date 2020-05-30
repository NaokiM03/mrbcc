require 'fileutils'

MRUBY_VERSION="2.1.0"

file :mruby do
  #sh "git clone --depth=1 https://github.com/mruby/mruby"
  sh "curl -L --fail --retry 3 --retry-delay 1 https://github.com/mruby/mruby/archive/2.1.0.tar.gz -s -o - | tar zxf -"
  FileUtils.mv("mruby-2.1.0", "mruby")
end

APP_NAME=ENV["APP_NAME"] || "mrbcc"
APP_ROOT=ENV["APP_ROOT"] || Dir.pwd
# avoid redefining constants in mruby Rakefile
mruby_root=File.expand_path(ENV["MRUBY_ROOT"] || "#{APP_ROOT}/mruby")
mruby_config=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
ENV['MRUBY_ROOT'] = mruby_root
ENV['MRUBY_CONFIG'] = mruby_config
Rake::Task[:mruby].invoke unless Dir.exist?(mruby_root)
Dir.chdir(mruby_root)
load "#{mruby_root}/Rakefile"

desc "compile binary"
task :compile => [:all] do
  bin = "#{mruby_root}/build/x86_64-pc-linux-gnu/bin/#{APP_NAME}"
  sh "strip --strip-unneeded #{bin}" if File.exist?(bin)
end

desc "cleanup"
task :clean do
  sh "rake deep_clean"
end
