# encoding: utf-8
# frozen_string_literal: true
# author: Patrick Münch
# author: Christoph Hartmann
# author: Dominik Richter

module Patcher
  class InSpecProfile
    def supported_profile(name)
      valid = %w{linux-patch-baseline}.include? name
      if !valid
        # puts "Profile #{name} is not supported"
      end
      valid
    end

    def extract_patchlist(results)
      packagelist = []
      results.each { |key, _array|
        package = {
          'name' => key['code_desc'].split(' ')[2],
          'version' => key['message'].split("\n")[1].match(/\"(\w*.*)\"/)[1]
        }
        packagelist.push(package)
      }
      packagelist
    end

    def scan_report(report)
      profiles = report['profiles']
      packagelist = []
      if !profiles.nil? && !profiles.empty?
        profiles.each { |profile|
          name = profile['name']
          # puts "Check profile #{name}"
          next if !supported_profile(name)
          controls = profile['controls']

          controls.select { |control|  control['id'] == 'patches'  }.each { |control|
            packagelist += extract_patchlist(control['results'])
          }
        }

        # sort package list
        packagelist.sort! { |x,y| x['name'] <=> y['name'] }

        return packagelist
      else
        # puts "InSpec report is empty"
        return []
      end
    end
  end
end
