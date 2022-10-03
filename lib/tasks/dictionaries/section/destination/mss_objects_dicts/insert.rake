namespace :dictionaries do
  namespace :section do
    namespace :destination do
      namespace :mss_objects_dicts do

        task :insert do |t|
          def link_param_query(code)
            Destination.set_engine!
            
            Destination.mss_objects_params
            .project(Destination.mss_objects_params[:link])
            .where(Destination.mss_objects_params[:code].eq(code))
          end
          
          def query
            Source.set_engine!
            
            Source.propsections
            .project([
              Source.propsections[:name],
            ])
            .where(Source.propsections[:name].not_eq(nil))
          end

          begin
            link_dict = Destination.execute_query(link_param_query('SECTION').to_sql).entries.first["link"]

            sql = ""
            insert = []
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  name: row['name']&.strip,
                  link_dict: link_dict,
                  row_id: Arel.sql('newid()'),
                }
              end

              condition =<<~SQL
                mss_objects_dicts.name = values_table.name
                  and mss_objects_dicts.link_dict = values_table.link_dict
              SQL

              sql = Destination::MssObjectsDicts.insert_query(rows: insert, condition: condition)
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
