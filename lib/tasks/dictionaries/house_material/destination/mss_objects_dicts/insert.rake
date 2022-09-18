namespace :dictionaries do
  namespace :house_material do
    namespace :destination do
      namespace :mss_objects_dicts do

        task :insert do |t|
          def link_param_query(code)
            Destination.set_engine!
            query = 
              Destination.mss_objects_params
              .project(Destination.mss_objects_params[:link])
              .where(Destination.mss_objects_params[:code].eq(code))
          end
          
          def query
            Source.set_engine!
            select_one = 
              Source.buildmaterials
              .project([
                Source.buildmaterials[:name],
              ])
              .where(Source.buildmaterials[:name].not_eq(nil))

            select_two =
              Source.objects
              .project([
                Arel.sql(
                  "ltrim(rtrim(
                      replace(replace([enginf].[material], char(9), ''), char(10), '')
                    ))"
                ).as("name")
              ])
              .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
              .join(Source.enginf).on(Source.enginf[:objects_id].eq(Source.objects[:id]))
              .join(Source.enginftypes, Arel::Nodes::OuterJoin).on(Source.enginftypes[:id].eq(Source.enginf[:enginftypes_id]))
              .where(Source.objtypes[:name].eq('Инженерная инфраструктура')
                .and(Source.enginf[:material].not_eq(nil))
              )

            union = select_one.union :all, select_two
            union_table = Arel::Table.new :union_table

            manager = Arel::SelectManager.new
            manager.project(Arel.star)
            manager.distinct
            manager.from(union_table.create_table_alias(union,:union_table))
          end

          begin
            link_dict = Destination.execute_query(link_param_query('HOUSE_MATERIAL').to_sql).entries.first["link"]

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
