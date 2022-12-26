namespace :dictionaries do
  namespace :main_otr do
    namespace :destination do
      namespace :mss_objcorr_dictsimptext do

        task :insert do |t|
          def link_prop_query
            Destination.mss_objcorr_props
            .project(Destination.mss_objcorr_props[:link])
            .where(Destination.mss_objcorr_props[:code].eq('MAIN_OTR'))
          end

          
          def query
            link_prop = Destination.execute_query(link_prop_query.to_sql).entries.first["link"]

            Source.___main_otrs
            .project([
              Source.___main_otrs[:name].as("value"),
              Arel.sql("#{ link_prop }").as("link_prop"),
              Source.___ids[:row_id],
            ])
            .join(Source.___ids).on(
              Source.___ids[:id].eq(Source.___main_otrs[:id])
              .and(Source.___ids[:table_id].eq(Source::MainOtrs.table_id))
            )
          end

          begin
            sql = ""
            insert = []
            
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  value: row['value'],
                  link_prop: row["link_prop"],
                  row_id: row["row_id"],
                }
              end

              condition =<<~SQL
                mss_objcorr_dictsimptext.value = values_table.value
                  and mss_objcorr_dictsimptext.link_prop = values_table.link_prop
              SQL

              sql = Destination::MssObjcorrDictsimptext.insert_query(rows: insert, condition: condition)
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
