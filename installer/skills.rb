def install_skills(dest_home, label, skills_root)
    puts "Would you like to install #{label} skills into #{dest_home}?"
    return unless are_you_sure?

    system "mkdir -p #{dest_home}"

    skills = File.directory?(skills_root) ?
        Dir.children(skills_root).select { |e| File.directory?("#{skills_root}/#{e}") } : []

    skills.each do |skill|
        dest = "#{dest_home}/#{skill}"
        orig = "#{skills_root}/#{skill}"

        if File.symlink?(dest) && File.readlink(dest) == orig
            puts "Skipping #{dest} (already linked correctly)"
        elsif File.directory?(dest) || File.symlink?(dest) || File.file?(dest)
            puts "#{dest} exists and will be erased."
            if are_you_sure?
                system "mkdir -p backup/"
                puts "cp -R #{dest} backup/"; system "cp -R #{dest} backup/"
                puts "rm -Rf #{dest}"; system "rm -Rf #{dest}"
                puts "Creating symlink #{dest} -> #{orig}"
                File.symlink(orig, dest)
            end
        else
            puts "Creating symlink #{dest} -> #{orig}"
            File.symlink(orig, dest)
        end
    end
end
