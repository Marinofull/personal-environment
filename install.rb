#The MIT License (MIT)
#
#Copyright (c) 2015 Marino Hohenhiem <marino@openmailbox.org, @Marinofull>
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
#
#Special thanks to dotfiles from Nilton Vasques <github.com/niltonvasques/dotfiles>

HOME = ENV['HOME']

def are_you_sure?
    print "Are you sure? [y/N]: "
    %w[y Y].include?(gets.chop)
end

def dotfiles_list
    dotfiles = Dir['.*'] - ['.', '..']
    dotfiles -= dotfiles.select{ |dot| dot[/.git/] || dot[/.swp/] }
    dotfiles += ['.gitconfig']
end

puts "I'm going to freaking initialize every fucking subrepo!"
if are_you_sure?
    puts "git submodule update --init --recursive"
    system "git submodule update --init --recursive"
end

puts "Would you like to install the default dotfiles like .vim, .tmux and some cool aliases?"
if are_you_sure?
    dotfiles_list.each do |dot|
        dest_file = "#{HOME}/#{dot}"
        dot = "#{Dir.pwd}/#{dot}"
        if File.file?(dest_file) || File.directory?(dest_file) || File.symlink?(dest_file)
            puts "#{dest_file} exists and will be erased."
            if are_you_sure?
                system "mkdir -p backup/"
                puts "cp -R #{dest_file} backup/"
                system "cp -R #{dest_file} backup/"
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
end

puts "Would you like to install the sublime-text snippets?"
if are_you_sure?
    folder = "snippets"
    dest = "#{HOME}/.config/sublime-text-3/Packages/User/#{folder}"
    orig = "#{Dir.pwd}/#{folder}"
    if File.directory?(dest) || File.symlink?(dest)
        puts "#{dest} exists and will be erased."
        if are_you_sure?
            system "mkdir -p backup/"
            puts "cp -R #{dest} backup/"
            system "cp -R #{dest} backup/"
            puts "rm -Rf #{dest}"
            system "rm -Rf #{dest}"
            puts "Creating symlink #{dest} -> #{orig}"
            File.symlink(orig, dest)
        end
    else
        puts "Creating symlink #{dest} -> #{orig}"
        File.symlink(orig, dest)
    end
end

puts "Do you want to install the Instant-Markdown plugin?"
puts "This is a plugins not tracked by pathogen and require Node.js and xdg-utils package, type y if you want to procede"
if are_you_sure?
    puts    "Do you want to install instant-markdown-d via npm? (this may require sudo)"
    if are_you_sure?
        puts    "npm -g install instant-markdown-d"
        system  "npm -g install instant-markdown-d"
    end
    puts    "cp -r .vim/tmp/vim-instant-markdown/after/ .vim/"
    system  "cp -r .vim/tmp/vim-instant-markdown/after/ .vim/"
end

system "mkdir -p tmp"

# reorganizes the pathogen directory
system "cp .vim/autoload/vim-pathogen/autoload/pathogen.vim .vim/autoload/"

# IO.readlines('file').map(&:strip).include?('alias')
# this instance returns a true value if file has alias

puts "we gonna append some alias on .bash_profile"
if are_you_sure?
    if !(IO.readlines(HOME + '/.bash_profile').map(&:strip).include?('#personal-functions'))
        system "echo '' >> ~/.bash_profile"
        system "echo '#personal-functions' >> ~/.bash_profile"
        system "echo '[[ -s \"$HOME/.aliases/append-bash\" ]] && source \"$HOME/.aliases/append-bash\"' >> ~/.bash_profile"
    else
        puts "you alredy have it, the string '#personal-functions' in your .bash_profile shows where it begins"
    end
end

puts "we gonna install the fucking awesome tool: powerline! This may need a sudo permission"
if are_you_sure?
    puts    "pip install --user powerline-status"
    system  "pip install --user powerline-status"
    puts    "wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf"
    system  "wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf"
    puts    "wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf"
    system  "wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf"
    puts    "mv PowerlineSymbols.otf /usr/share/fonts/"
    system  "mv PowerlineSymbols.otf /usr/share/fonts/"
    puts    "fc-cache -vf /usr/share/fonts/"
    system  "fc-cache -vf /usr/share/fonts/"
    puts    "mv 10-powerline-symbols.conf /etc/fonts/conf.d/"
    system  "mv 10-powerline-symbols.conf /etc/fonts/conf.d/"
end
