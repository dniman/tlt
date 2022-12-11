namespace :dictionaries do
  namespace :dictionary_agree_mode do
    namespace :destination do
      namespace :s_note do

        task :insert do |t|
          
          def query
            Source.transferbasis
            .project([
              Source.transferbasis[:name],
            ])
            .distinct
            .where(Source.transferbasis[:name].not_eq(nil))
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  value: row['name']&.strip,
                  object: Destination::SObjects.obj_id('DICTIONARY_AGREE_MODE'),
                  row_id: Arel.sql('newid()'),
                }
              end

              condition =<<~SQL
                s_note.value = values_table.value
                  and s_note.object = values_table.object
              SQL

              sql = Destination::SNote.insert_query(rows: insert, condition: condition)
              result = Destination.execute_query(sql)
              result.do
              insert.clear
              sql.clear
            end
            
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
