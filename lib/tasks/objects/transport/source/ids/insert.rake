namespace :objects do
  namespace :transport do
    namespace :source do
      namespace :ids do

        task :insert do |t|
          def link_type_query
            Destination.mss_objects_types 
            .project(Destination.mss_objects_types[:link])
            .where(Destination.mss_objects_types[:code].eq("TRANSPORT"))
          end

          def query
            Source.objects
            .project([
              Arel.sql("table_id = #{Source::Objects.table_id}"),
              Source.objects[:id],
              Arel.sql("row_id = newid()")
            ])
            .join(Source.objtypes, Arel::Nodes::OuterJoin).on(Source.objtypes[:id].eq(Source.objects[:objtypes_id]))
            .join(Source.transport).on(Source.transport[:objects_id].eq(Source.objects[:id]))
            .join(Source.transptype, Arel::Nodes::OuterJoin).on(Source.transptype[:id].eq(Source.transport[:transptype_id]))
            .where(Source.objtypes[:name].eq('Транспортные средства')
              .and(Source.transptype[:name].in(['Лодка', 'Катер', 'Теплоход', 'Мотолодка']).not)
            )
         end

          begin
            sql = ""
            insert = []
            link_type = Destination.execute_query(link_type_query.to_sql).entries.first["link"]
            sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  table_id: row["table_id"],
                  id: row["id"],
                  row_id: row["row_id"],
                  link_type: link_type
                }
              end
              sql = Source::Ids.insert_query(rows: insert, condition: "ids.id = values_table.id and ids.table_id = values_table.table_id")
              result = Source.execute_query(sql)
              result.do
              insert.clear
              sql.clear
            end

            Source.execute_query(sql).do
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
