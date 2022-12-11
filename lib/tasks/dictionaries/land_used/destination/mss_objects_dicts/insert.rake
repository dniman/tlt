namespace :dictionaries do
  namespace :land_used do
    namespace :destination do
      namespace :mss_objects_dicts do

        task :insert do |t|
          def link_param_query(code)
            Destination.mss_objects_params
            .project(Destination.mss_objects_params[:link])
            .where(Destination.mss_objects_params[:code].eq(code))
          end
          
          def query
            main = 
              Source.grounds
              .project([
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([grounds].[prec_doc], char(9), ''), char(10), '')
                    ))"
                ).as("prec_doc")
              ])
              .distinct

            cte_table = Arel::Table.new(:cte_table)  
            composed_cte = Arel::Nodes::As.new(cte_table, main)
            query =
              cte_table
                .project(
                  cte_table[:prec_doc]
                )
                .distinct
                .with(composed_cte)
                .where(cte_table[:prec_doc].not_eq(nil)
                  .and(cte_table[:prec_doc].not_eq(''))
                )
          end

          begin
            link_dict = Destination.execute_query(link_param_query('LAND_USED').to_sql).entries.first["link"]

            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  name: row['prec_doc']&.strip,
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
