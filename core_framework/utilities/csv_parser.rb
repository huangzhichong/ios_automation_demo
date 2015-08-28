require "csv"
module Utilities
  class CSVParser
    def initialize(file_path,options={},header=[])
      if File.exist? file_path
        file_content = File.read(file_path, :mode => "rb", :encoding => "bom|UTF-8").force_encoding("utf-8").gsub("\u0000","")
        @csv = CSV.parse(file_content, options)
        unless header.size > 0
          @header = @csv[0]
          #for check the csv only including header without other data(frank)
          @rows = @csv
          #@rows = @csv.drop(1)
        else
          @header = header
          @rows = @csv
        end
        @row_data = @rows.map{|r| Hash[ *@header.zip(r).flatten ]}
      else
        Common.logger_error "Execute - parse CSV of #{file_path} - failed. the file does NOT exist"
      end
    end

    def get_data_by_row_number_and_column_name(row, column_name)      
      if 0 < row && row <= @row_data.length
        if @row_data[row-1].has_key?(column_name)
          Common.logger_info "Execute - get data from CSV in row #{row} and column #{column_name} - success"
          return @row_data[row-1][column_name]
        else
          Common.logger_error "Execute - get data from CSV in row #{row} and column #{column_name} - failed. the column #{column_name} does NOT exist."
        end
      else
        Common.logger_error "Execute - get data from CSV in row #{row} and column #{column_name} - the row number #{row} is out of range"
      end
    end

    def check_data_by_row_number_and_column_name(row, column_name, expected_value)
      temp = get_data_by_row_number_and_column_name(row, column_name)
      if temp == expected_value
        Common.logger_info "Assert  - data in row #{row} and column #{column_name} is correct."
        true
      else
        Common.logger_error "Assert  - data in row #{row} and column #{column_name} is wrong. get [#{temp}] while [#{expected_value}] is expected."
      end
    end

    def get_instance_count_by_row_data_hash(row_hash)
      count = 0
      @row_data.each do |row|
        count +=1 if row.merge(row_hash) == row
      end
      Common.logger_info "Execute - get instance count by row data - success. there is #{count} instances of #{row_hash}"
      return count
    end

    def check_row_data_included_by_hash(row_hash)
      @row_data.each do |row|
        puts row
        if row.merge(row_hash) == row
          Common.logger_info "Assert  - check if row data included by Hash - success."
          return true
        end
      end
      Common.logger_error "Assert  - check if row data included by Hash - failed. the row data #{row_hash} does not exist."
    end
  end
end
