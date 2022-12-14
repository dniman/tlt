namespace :dictionaries do
  namespace :land_kateg do
    namespace :destination do
      namespace :mss_objects_dicts do

        task :insert do |t|
          def link_param_query(code)
            Destination.mss_objects_params
            .project(Destination.mss_objects_params[:link])
            .where(Destination.mss_objects_params[:code].eq(code))
          end

          def query
            cte_table = Arel::Table.new(:cte_table)
            main_select = 
              Source.groundtypes
              .project(
                Source.groundtypes[:id],
                Source.groundtypes[:code],
                Source.groundtypes[:name],
                Source.groundtypes[:root]
              )
              .where(Source.groundtypes[:root].eq(nil))

            child_select = 
              Source.groundtypes
              .project(
                Source.groundtypes[:id],
                Source.groundtypes[:code],
                Source.groundtypes[:name],
                Source.groundtypes[:root]
              )
              .join(cte_table).on(cte_table[:id].eq(Source.groundtypes[:root]))

            union = main_select.union :all, child_select 
            composed_cte = Arel::Nodes::As.new(cte_table, union)

            query =
              cte_table
                .project(
                  cte_table[:code],
                  cte_table[:name]
                )
                .with(composed_cte)
                .order(cte_table[:code], cte_table[:id])
          end

          begin
            link_dict = Destination.execute_query(link_param_query('LAND_KATEG').to_sql).entries.first["link"]

            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  name: row['name']&.strip,
                  code: row['name']&.strip == 'рекреационного и историко-культурного назначения' ? '003004000000_1' : row['code'], 
                  link_dict: link_dict,
                  row_id: Arel.sql('newid()'),
                }
              end
              condition =<<~SQL
                mss_objects_dicts.code = values_table.code
                  and mss_objects_dicts.name = values_table.name
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
