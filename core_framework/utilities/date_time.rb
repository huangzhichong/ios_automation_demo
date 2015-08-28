module Utilities
  module DateTime
    class << self
      #description:get the time day of the agency time zone
      #example: Utilities::DateTime.get_next_day_by_agency_timezone "US/Pacific"
      def get_next_day_by_agency_timezone(time_zone)
        convert_current_local_time_to_next_day_by_timezone(time_zone)
      end

      #description: convert the local time to the time on the defined time zone
      #parameters:
      #            localTime: the local time
      #            time_zone: time zone
      #example: Utilities::DateTime.convert_local_time_by_timezone Time.now, "US/Pacific"
      def convert_local_time_by_timezone(local_time,time_zone)
        tz = TZInfo::Timezone.get(time_zone)
        return tz.utc_to_local(local_time.getutc)
      end

      #description: convert the utc time to the time on the defined time zone
      #parameters:
      #            utcTime: the utc time
      #            time_zone: time zone
      #example: Utilities::DateTime.convert_utc_time_by_timezone "2010-10-10 10:00:00", "US/Pacific","%-m/%-d/%Y"
      def convert_utc_time_by_timezone(utc_time,time_zone,format)
        tz = TZInfo::Timezone.get(time_zone)
        ftime = Time.strptime(utc_time,"%Y-%m-%d %H:%M:%S")
        return tz.utc_to_local(ftime).strftime(format)
      end

      #description: convert the local now to the next day on the defined time zone
      #parameters:
      #            time_zone: time zone
      #example: Utilities::DateTime.convert_current_local_time_to_next_day_by_timezone  "US/Pacific"
      def convert_current_local_time_to_next_day_by_timezone(time_zone)
        format="%-m/%-d/%Y"
        # format="%m/%d/%y"
        tz = convert_local_time_by_timezone Time.now+86400,time_zone
        return tz.strftime(format)
      end

      #description: convert the time zone time to the utc time
      #parameters:
      #            time: time
      #            time_zone: time zone
      #example: Utilities::DateTime.convert_time_by_timezone_to_utc "2010-10-10 10:00:00"  "US/Pacific"
      def convert_time_by_timezone_to_utc(time,time_zone)
        tz = TZInfo::Timezone.get(time_zone)
        ftime = Time.strptime(time,"%Y-%m-%d %H:%M:%S")
        return tz.local_to_utc(ftime)
      end

      def get_time_by_format(time,format)
        standard_time = Time.strptime(time,'%Y-%m-%d')
        return standard_time.strftime(format)
      end

      def get_age_by_birthday(birthday)
        standard_time = Time.strptime(birthday,'%Y-%m-%d')
        sec_diffenence = Time.now - standard_time
        return (sec_diffenence/(365*24*60*60)).to_i
      end

      def get_second_difference(from,to)
        standard_time_from = Time.strptime(from,'%Y-%m-%d')
        standard_time_to = Time.strptime(to,'%Y-%m-%d')
        sec_diffenence = standard_time_to - standard_time_from
        return (sec_diffenence/(365*24*60*60)).to_i
      end

      def get_two_digits_month_by_month_name(month)
        str_month = month.to_s
        if str_month.length == 1
          str_month = "0#{str_month}"
        end
        str_month
      end
    end

  end
end
