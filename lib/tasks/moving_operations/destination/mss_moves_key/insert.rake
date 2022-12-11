namespace :moving_operations do
  namespace :destination do
    namespace :mss_moves_key do

      task :insert do |t|

        def query 
          Source.___moving_operations
          .project([
            Source.___moving_operations[:___link_a],
            Source.___moving_operations[:___link_pc0],
            Source.___ids[:row_id],
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___moving_operations[:id]).and(Source.___ids[:table_id].eq(Source::MovingOperations.table_id)))
        end
        
        begin
          sql = ""
          insert = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                link_a: row["___link_a"],
                link_pc0: row["___link_pc0"],
                row_id: row["row_id"],
              }
            end
            sql = Destination::MssMovesKey.insert_query(rows: insert, condition: "mss_moves_key.row_id = values_table.row_id")
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
