namespace :dictionaries do
  namespace :doc do
    namespace :destination do
      namespace :mss_doc_types do

        task :insert do |t|
          
          def link_base_query
            Destination.mss_objcorr_types
            .project(Destination.mss_objcorr_types[:link])
            .where(Destination.mss_objcorr_types[:code].eq('doc'))
          end

          def query
            link_base = Destination.execute_query(link_base_query.to_sql).entries.first["link"]

            Destination.mss_objcorr_types
            .project([
              Destination.mss_objcorr_types[:link],
            ])
            .distinct
            .where(Destination.mss_objcorr_types[:link_base].eq(link_base)
              .and(Destination.mss_objcorr_types[:code].matches("dtsaumiToll_%"))
            )
          end

          begin
            sql = ""
            insert = []
            index = 1
            
            sliced_rows = Destination.execute_query(query.to_sql).each_slice(1000).to_a
            sliced_rows.each do |rows|
              rows.each do |row|
                insert << {
                  link: row["link"],
                  link_right_state: 0,
                  doc_object: Destination::MssDocTypes::MSS_DOCS_COMMON
                }
                index += 1
              end
            end

            condition =<<~SQL
              mss_doc_types.link = values_table.link
                and mss_doc_types.doc_object = #{ Destination::MssDocTypes::MSS_DOCS_COMMON }
            SQL

            sql = Destination::MssDocTypes.insert_query(rows: insert, condition: condition)
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
