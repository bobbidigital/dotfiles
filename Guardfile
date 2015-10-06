# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec feature)

## Uncomment to clear the screen before every task
# clearing :on

## Guard internally checks for changes in the Guardfile and exits.
## If you want Guard to automatically start up again, run guard in a
## shell loop, e.g.:
##
##  $ while bundle exec guard; do echo "Restarting Guard..."; done
##
## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), the you will want to move the Guardfile
## to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"
#

clearing :on

group :puppet do
  
  #guard 'puppet-lint', :watchdir => Guard.options[:watchdir],
  #                     :show_warnings => false,
  #                     :syntax_check  => true\
  #do	
  #   watch(/(.*).pp$/)
  #end

  guard :shell do
    watch /(.*\.pp$)/ do |m|
        parser = `puppet parser validate --color=false #{m[0]}`
        retval = $?.to_i
        case retval
            when 0
                n "#{m[0]} Parser can parse!", 'Puppet-Parser'
            else
                n "#{m[0]} Parser can't parse! #{parser}", 'Puppet-Parser', :failed
        end
        lint = `puppet-lint --with-filename #{m[0]}`
        retval = $?.to_i
        case retval
            when 0
                if lint.length > 0 then
                    puts lint
                    n "#{m[0]} You can do better, warnings left on Terminal!", 'Puppet-Lint', :pending
                else
                    puts lint
                    n "#{m[0]} Fully lintified!", 'Puppet-Lint', :success
                end
            else
                puts lint
                n "#{m[0]} There are errors on Terminal left!", 'Puppet-Lint', :failed
        end
    end
    watch /(.*\.erb$)/ do |m|
        case system "cat #{m[0]} | erb -P -x -T - | ruby -c"
            when true
                n "#{m[0]} is valid", 'ERB-Check'
            when false
                n "#{m[0]} is invalid", 'ERB-Check', :failed
        end
    end
    watch /(.*\.rb$)/ do |m|
        case system "ruby -c #{m[0]}"
            when true
                n "#{m[0]} is valid", 'Ruby-Syntax-Check'
            when false
                n "#{m[0]} is invalid", 'Ruby-Syntax-Check', :failed
        end
    end
 end
end


# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
guard :shell do
  watch(/(.*).txt/) {|m| `tail #{m[0]}` }
end
