namespace :dictionaries do
  namespace :doc do
    namespace :destination do
      namespace :mss_objcorr_types do

        task :insert do |t|
          
          def link_base_query
            Destination.mss_objcorr_types
            .project(Destination.mss_objcorr_types[:link])
            .where(Destination.mss_objcorr_types[:code].eq('doc'))
          end

          def query
            Source.doctypes
            .project([
              Source.doctypes[:name],
            ])
            .distinct
            .where(Source.doctypes[:name].not_eq(nil))
          end

          begin
            link_base = Destination.execute_query(link_base_query.to_sql).entries.first["link"]

            sql = ""
            insert = []
            index = 1
            
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            
              rows.each do |row|
                insert << {
                  code: Arel.sql("'dtsaumiToll_#{index}'"),
                  name: row["name"],
                  link_base: link_base.to_s,
                  row_id: Arel.sql('newid()'),
                }
                index += 1
              end
            end

            condition =<<~SQL
              mss_objcorr_types.name = values_table.name
                and mss_objcorr_types.link_base = values_table.link_base
            SQL

            sql = Destination::MssObjcorrTypes.insert_query(rows: insert, condition: condition)
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
