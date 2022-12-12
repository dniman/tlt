namespace :agreements do
  namespace :destination do
    namespace :agreement_sign do
      namespace :arh_final do

        task :insert do |t|
          def stat_query
            manager = Arel::SelectManager.new Database.destination_engine
            manager.project(Destination.s_note[:link])
            manager.from(Destination.s_note)
            manager.where(Destination.s_note[:code].eq('ARH_FINAL'))
            manager.to_sql
          end

          def query
            stat = Destination.execute_query(stat_query).entries.first["link"]

            Source.___agreements
            .project([
              Source.___ids[:link].as("link_up"),
              Arel.sql("#{ stat }").as("stat"),
            ])
            .join(Source.___ids).on(Source.___ids[:id].eq(Source.___agreements[:id]).and(Source.___ids[:table_id].eq(Source::Agreements.table_id)))
            .where(Source.___agreements[:___docstate_name].eq('Архивный, прекращен'))
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

              sql = Destination::AgreementSign.insert_query(rows: insert, condition: "agreement_sign.link_up = values_table.link_up and agreement_sign.stat = values_table.stat")
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
