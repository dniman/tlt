namespace :import do
  namespace :land do
    namespace :destination do
      namespace :mss_objects_dicts do
        namespace :link_dict do
          namespace :obj_zkx do

            task :insert do |t|
              def link_type_query
                Destination.set_engine!
                query = 
                  Destination.mss_objects_types 
                  .project(Destination.mss_objects_types[:link])
                  .where(Destination.mss_objects_types[:code].eq("LAND"))
              end
              
              def link_param_query(code)
                Destination.set_engine!
                query = 
                  Destination.mss_objects_params
                  .project(Destination.mss_objects_params[:link])
                  .where(Destination.mss_objects_params[:code].eq(code))
              end

              begin
                link_dict = Destination.execute_query(link_param_query('OBJ_ZKX').to_sql).entries.first["link"]

                sql = ""
                insert = []
                rows = [{'is_zhkh' => 'Да'}, {'is_zhkh' => 'Нет'}]
                rows.each do |row|
                  insert << {
                    name: row["is_zhkh"],
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
end
