module UsersHelper
  def timezones
    ActiveSupport::TimeZone.all.
      group_by{|x| x.utc_offset}.
      sort_by{|n, a| -n}.
      map{|n, a|
        offset = a.first.formatted_offset
        names = a.map(&:name).join ', '
        ["#{offset} #{names}", n]
      }
    ActiveSupport::TimeZone.all.map{|tz|
      ["#{tz.formatted_offset} #{tz.name}", tz.name]
    }
  end
end
