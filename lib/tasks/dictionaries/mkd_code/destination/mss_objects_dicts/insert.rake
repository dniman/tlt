namespace :dictionaries do
  namespace :mkd_code do
    namespace :destination do
      namespace :mss_objects_dicts do

        task :insert do |t|
          def link_param_query(code)
            Destination.mss_objects_params
            .project(Destination.mss_objects_params[:link])
            .where(Destination.mss_objects_params[:code].eq(code))
          end
          
          def query

            name =
              Arel::Nodes::Concat.new(
                Arel::Nodes::NamedFunction.new('isnull', [ Source.reg_operator_kod_erin[:street_name], Arel.sql("''")]),
                Arel.sql("','")
              )
            
            name =
              Arel::Nodes::Concat.new(
                name,
                Arel::Nodes::NamedFunction.new('isnull', [ Source.reg_operator_kod_erin[:num_home], Arel.sql("''")])
              )

            name = 
              Arel::Nodes::Concat.new(
                name,
                Arel.sql("','")
              )

            name = 
              Arel::Nodes::Concat.new(
                name,
                Arel::Nodes::NamedFunction.new('isnull', [ Source.reg_operator_kod_erin[:lit], Arel.sql("''")])
              )

            Source.reg_operator_kod_erin
            .project([
              Source.reg_operator_kod_erin[:cod_rp].as("code"),
              name.as("name"),
              Source.reg_operator_kod_erin[:comm].as("note"),
            ])
            .where(Source.reg_operator_kod_erin[:cod_rp].not_eq(nil))
          end

          begin
            link_dict = Destination.execute_query(link_param_query('MKD_CODE').to_sql).entries.first["link"]

            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  code: row['code'],
                  name: row['name']&.strip,
                  note: row["note"],
                  link_dict: link_dict,
                  row_id: Arel.sql('newid()'),
                }
              end

              condition =<<~SQL
                mss_objects_dicts.code = values_table.code
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
