require "query_storage/version"

module QueryStorage
  class << self

    def execute_sql sql
      con = ActiveRecord::Base.connection
      con.select_all(sql)
    end

    def is_insert_or_update_sql sql
      return sql.match(/\bupdate\b|\binsert\b/).present?
    end


    def get_csv_data input_data, has_header=false
      csv_data = CSV.generate("", :headers => input_data[0].keys, :write_headers => has_header) do |csv|
        input_data.each_with_index do |record, index|
          csv << record
        end
      end
      return csv_data
    end

    def get_csv_data_array list, key_order=nil
      key_order ||= list.map(&:keys).flatten.uniq
      arr = list.map do |hash|
        key_order.map{|key| hash[key]}
      end
      arr.unshift(key_order).map{|a| a.join(", ").insert(-1, "\n") }.join
    end

    def get_tsv_data input_data, has_header=false
      tsv_data = CSV.generate("", :headers => input_data[0].keys, :write_headers => has_header, :col_sep => "\t") do |tsv|
        input_data.each_with_index do |record, index|
          tsv << record
        end
      end
      return tsv_data
    end

  end
end
