namespace :paycards do
  namespace :destination do
    namespace :paycard_sign do
      namespace :stage_reg do

        task :insert do |t|
          def stat_query
            manager = Arel::SelectManager.new Database.destination_engine
            manager.project(Destination.s_note[:link])
            manager.from(Destination.s_note)
            manager.where(Destination.s_note[:code].eq('STAGE_REG'))
            manager.to_sql
          end

          def query
            stat = Destination.execute_query(stat_query).entries.first["link"]

            Source.___paycards
            .project([
              Source.___ids[:link].as("link_up"),
              Arel.sql("#{ stat }").as("stat"),
            ])
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.___paycards[:id]).and(Source.___ids[:table_id].eq(Source::Paycards.table_id)))
            .where(Source.___paycards[:in_progress].eq('Y'))
          end

          begin
            sql = ""
            insert = []
            Source.execute_query(query.to_sql).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  link_up: row["link_up"],
                  stat: row["stat"],
                }
              end

              sql = Destination::PaycardSign.insert_query(rows: insert, condition: "paycard_sign.link_up = values_table.link_up and paycard_sign.stat = values_table.stat")
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
