namespace :payments do
  namespace :destination do
    namespace :entry do

      task :insert do |t|
        def query 
          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            Arel.sql(Destination::Rem1::DOCUMENTS_0401003A.to_s).as("object"),
            Source.___ids[:row_id],
          ])
          manager.from(Source.___ids)
          manager.where(
            Source.___ids[:table_id].eq(Source::Payments.table_id)
          )
          manager.to_sql
        end
        
        begin
          sql = ""
          insert = []

          Source.execute_query(query).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                object: row["object"],
                row_id: row["row_id"],
              }
            end
            sql = Destination::Entry.insert_query(rows: insert, condition: "entry.row_id = values_table.row_id")
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
