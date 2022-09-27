namespace :dictionaries do
  namespace :kbk do
    namespace :destination do
      namespace :t_kbk do
        namespace :ref_inc_prog do

          task :insert do |t|
            def query
              Source.set_engine!

              Source.cls_kbk
              .project([
                Source.cls_kbk[:___link_kbk_inc],
                Source.cls_kbk[:___link_program],
              ])
              .where(Source.cls_kbk[:___link_kbk_inc].not_eq(nil)
                .and(Source.cls_kbk[:___link_program].not_eq(nil))
              )
            end

            begin
              sql = ""
              insert = []
              index = 1
              
              sliced_rows = Source.execute_query(query.to_sql).each_slice(1000).to_a
              sliced_rows.each do |rows|
                rows.each do |row|
                  insert << {
                    ref1: row["___link_kbk_inc"],
                    object: Destination::TKbk::REF_INC_PROG,
                    ref2: row["___link_program"],
                  }
                end
              end

              condition =<<~SQL
                t_kbk.ref1 = values_table.ref1
                  and t_kbk.object = #{ Destination::TKbk::REF_INC_PROG }
                  and t_kbk.ref2 = values_table.ref2
              SQL

              sql = Destination::TKbk.insert_query(rows: insert, condition: condition)
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
end
