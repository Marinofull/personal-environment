require 'json'

def install_claude_settings(dotfiles_root)
    puts "Would you like to build and install Claude Code settings?"
    return unless are_you_sure?

    home = ENV['HOME']
    template_path = "#{dotfiles_root}/claude/settings.json"
    build_dir     = "#{dotfiles_root}/build/claude"
    build_path    = "#{build_dir}/settings.json"
    dest_path     = "#{home}/.claude/settings.json"

    system "mkdir -p #{build_dir}"
    system "mkdir -p #{home}/.claude"

    built = File.read(template_path)
        .gsub("{{DOTFILES_ROOT}}", dotfiles_root)
        .gsub("{{HOME}}", home)
    File.write(build_path, built)
    puts "Built #{build_path}"

    if File.symlink?(dest_path) && File.readlink(dest_path) == build_path
        puts "Skipping #{dest_path} (already linked correctly)"
    elsif File.exist?(dest_path) || File.symlink?(dest_path)
        puts "#{dest_path} exists and will be backed up and replaced."
        if are_you_sure?
            system "mkdir -p #{dotfiles_root}/backup"
            system "cp #{dest_path} #{dotfiles_root}/backup/"
            system "rm #{dest_path}"
            puts "Creating symlink #{dest_path} -> #{build_path}"
            File.symlink(build_path, dest_path)
        end
    else
        puts "Creating symlink #{dest_path} -> #{build_path}"
        File.symlink(build_path, dest_path)
    end

end

def install_codex_settings(dotfiles_root)
    puts "Would you like to configure Codex settings (caveman always-on at session start)?"
    return unless are_you_sure?

    home = ENV['HOME']
    agents_path = "#{home}/.codex/AGENTS.md"
    system "mkdir -p #{home}/.codex"
    File.write(agents_path, "") unless File.exist?(agents_path)

    include_line = "@#{dotfiles_root}/caveman_skill/skills/caveman/SKILL.md"
    content = File.read(agents_path)

    if content.include?(include_line)
        puts "Skipping caveman entry in #{agents_path} (already present)"
    else
        File.open(agents_path, "a") { |f| f.puts include_line }
        puts "Added caveman always-on to #{agents_path}"
    end
end

def install_copilot_settings(dotfiles_root)
    puts "Skipping Copilot caveman setup (disabled: Copilot bills per request, not tokens)"

    # Uncomment below to re-enable caveman always-on for Copilot CLI:
    #
    # return unless are_you_sure?
    # home = ENV['HOME']
    # config_path = "#{home}/.copilot/config.json"
    # system "mkdir -p #{home}/.copilot"
    # raw = File.exist?(config_path) ? File.read(config_path) : "{}"
    # stripped = raw.gsub(/^\s*\/\/.*$/, "")  # config.json uses JS-style // comments
    # config = JSON.parse(stripped.empty? ? "{}" : stripped)
    # skill_md = "#{dotfiles_root}/caveman_skill/skills/caveman/SKILL.md"
    # caveman_hook = { "command" => "cat #{skill_md}" }
    # config["hooks"] ||= {}
    # config["hooks"]["session-start"] ||= []
    # if config["hooks"]["session-start"].any? { |h| h["command"]&.include?("caveman_skill") }
    #     puts "Skipping caveman hook in #{config_path} (already present)"
    # else
    #     config["hooks"]["session-start"] << caveman_hook
    #     header = raw.lines.select { |l| l.strip.start_with?("//") }.join
    #     File.write(config_path, header + JSON.pretty_generate(config) + "\n")
    #     puts "Added caveman always-on hook to #{config_path}"
    # end
end
