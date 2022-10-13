namespace :dictionaries do
  namespace :target_doc_target_doc_id do
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
              Source.target_doc
              .project(
                Source.target_doc[:id],
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([target_doc].[name], char(9), ''), char(10), '')
                    ))"
                ).as("name"),
                Source.target_doc[:root]
              )
              .where(Source.target_doc[:root].eq(nil))
            
            child_select = 
              Source.target_doc
              .project(
                Source.target_doc[:id],
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([target_doc].[name], char(9), ''), char(10), '')
                    ))"
                ).as("name"),
                Source.target_doc[:root]
              )
              .join(cte_table).on(cte_table[:id].eq(Source.target_doc[:root]))

            union = main_select.union :all, child_select 
            composed_cte = Arel::Nodes::As.new(cte_table, union)

            query =
              cte_table
                .project(
                  cte_table[:name],
                )
                .distinct
                .with(composed_cte)
                .where(cte_table[:name].not_eq(nil)
                  .and(cte_table[:name].not_eq(''))
                )
          end


          begin
            link_dict = Destination.execute_query(link_param_query('TARGET_DOC_TARGET_DOC_ID').to_sql).entries.first["link"]

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
