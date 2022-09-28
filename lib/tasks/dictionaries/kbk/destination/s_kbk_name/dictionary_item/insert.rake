namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :s_kbk_name do
        namespace :dictionary_item do

          task :insert do |t|
            def query
              Source.set_engine!

              Source.cls_kbk
              .project([
                Source.cls_kbk[:___link_item],
                Source.cls_kbk[:name],
              ])
              .distinct
              .where(Source.cls_kbk[:name].not_eq(nil))
            end

            begin
              sql = ""
              insert = []
              index = 1
              
              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                rows.each do |row|
                  insert << {
                    link_up: row["___link_item"],
                    sname: row["name"].strip[17,3],
                    name: row["name"].strip[17,3],
                  }
                end
              end

              condition =<<~SQL
                s_kbk_name.link_up = values_table.link_up
              SQL

              sql = Destination::SKbkName.insert_query(rows: insert, condition: condition)
              result = Destination.execute_query(sql)
              result.do
              insert.clear
              sql.clear
              
              Rake.info "Задача '#{ t }' успешно выполнена."
            rescue StandardError => e
              Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
              Rake.info "Текст запроса \"#{ sql }\""

              exit
            end
          end

        end
      end
    end
  end
end