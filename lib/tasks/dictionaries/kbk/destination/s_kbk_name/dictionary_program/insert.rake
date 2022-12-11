namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :s_kbk_name do
        namespace :dictionary_program do

          task :insert do |t|
            def query
              Source.cls_kbk
              .project([
                Source.cls_kbk[:___link_program],
                Source.cls_kbk[:name],
              ])
              .distinct
              .where(Source.cls_kbk[:name].not_eq(nil))
            end

            begin
              sql = ""
              insert = []
              index = 1
              
              Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              
                rows.each do |row|
                  insert << {
                    link_up: row["___link_program"],
                    sname: row["name"].strip[13,4],
                    name: row["name"].strip[13,4],
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
