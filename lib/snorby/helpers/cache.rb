module Snorby
  module Helpers
    module Cache

      def severity_count(severity, collection)
        count = []
        @cache = collection

        case severity.to_sym
        when :high
          @cache.each do |hour, data|
            count[hour] = data.count
          end
        when :medium
          @cache.each do |hour, data|
            count[hour] = data.size
          end
        when :low
          @cache.each do |hour, data|
            count[hour] = data.size
          end
        end

        range_for_type(:hour) do |i|
          next if count[i]
          count[i] = 0
        end

        count
      end


      def range_for_type(type=:week, &block)

        case type.to_sym
        when :hour
          Time.now.beginning_of_day.hour.upto(Time.now.end_of_day.hour) do |i|
            block.call(i) if block
          end
        when :week
          Time.now.beginning_of_week.day.upto(Time.now.end_of_week.day) do |i|
            block.call(i) if block
          end
        when :month
          Time.now.beginning_of_month.day.upto(Time.now.end_of_month.day) do |i|
            block.call(i) if block
          end
        when :year
          start_time_method = :beginning_of_year
          end_time_method = :end_of_year
          Time.now.beginning_of_year.month.upto(Time.now.end_of_year.month) do |i|
            block.call(i) if block
          end
        else
          Time.now.beginning_of_week.day.upto(Time.now.end_of_week.day) do |i|
            block.call(i) if block
          end
        end

      end

    end
  end
end
