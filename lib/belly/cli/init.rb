options = Trollop::options do
  banner <<-EOF
This is the help for the init command. To see all commands availlable, type belly --help

Usage: belly init

Initialize your project for use with the belly service

EOF
end

if File.exists?('features/support')
  target = 'features/support/belly.rb'
  if File.exists?(target)
    Trollop.die("There's already a #{target} which I was going to create. Not much for me to do")
  end
  File.open(target, 'w') do |f|
    f.puts "require 'belly/for/cucumber'"
    puts "Created #{target}"
  end
end