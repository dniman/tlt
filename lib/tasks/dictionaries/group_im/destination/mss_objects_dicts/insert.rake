namespace :dictionaries do
  namespace :group_im do
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
              Source.infgroups
              .project(
                Source.infgroups[:id],
                Source.infgroups[:name],
                Source.infgroups[:root]
              )
              .where(Source.infgroups[:root].eq(nil))

            child_select = 
              Source.infgroups
              .project(
                Source.infgroups[:id],
                Source.infgroups[:name],
                Source.infgroups[:root]
              )
              .join(cte_table).on(cte_table[:id].eq(Source.infgroups[:root]))

            union = main_select.union :all, child_select 
            composed_cte = Arel::Nodes::As.new(cte_table, union)

            query =
              cte_table
                .project(
                  cte_table[:name]
                )
                .distinct
                .with(composed_cte)
                #.order(cte_table[:root], cte_table[:id])
          end

          begin
            link_dict = Destination.execute_query(link_param_query('GROUP_IM').to_sql).entries.first["link"]

            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
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
