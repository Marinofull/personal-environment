HOME = ENV['HOME']

def are_you_sure?
    print "Are you sure? [y/N]: "
    %w[y Y].include?(gets.chop)
end

def dotfiles_list
    dotfiles = Dir['.*'] - ['.', '..']
    dotfiles -= dotfiles.select{ |dot| dot[/.git/] || dot[/.swp/] }
end

dotfiles_list.each do |dot|
    dest_file = "#{HOME}/#{dot}"
    dot = "#{Dir.pwd}/#{dot}"
    if File.file?(dest_file) || File.directory?(dest_file) || File.symlink?(dest_file)
        puts "#{dest_file} exists and will be erased."
        if are_you_sure?
            puts "rm -Rf #{dest_file}"
            system "rm -Rf #{dest_file}"
            puts "Creating symlink #{dest_file} -> #{dot}"
            File.symlink(dot, dest_file)
        end
    else
        puts "Creating symlink #{dest_file} -> #{dot}"
        File.symlink(dot, dest_file)
    end
end

system "cat duckit >> #{HOME}/.bashrc"

