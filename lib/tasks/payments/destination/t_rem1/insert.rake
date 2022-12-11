namespace :payments do
  namespace :destination do
    namespace :t_rem1 do

      task :insert do |t|

        def link_self_query
          Destination.rem1
          .project(Destination.rem1[:link])
          .where(Destination.rem1[:object].eq(Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')))
        end

        def query 
          link_self = Destination.execute_query(link_self_query.to_sql).entries.first["link"]

          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            Arel.sql("#{link_self}").as("ref1"),
            Source.payments[:___rem1].as("ref2"),
            Arel.sql("#{Destination::TRem1::DOCUMENTS_ADM_VIP}").as("obj_up"),
            Arel.sql("#{Destination::TRem1::CHAIN_PP_ADM}").as("obj_up"),
          ])
          manager.from(Source.payments)
          manager.where(Source.payments[:___type].eq(2))
          manager.to_sql
        end
        
        begin
          sql = ""
          insert = []

          Source.execute_query(query).each_slice(1000) do |rows|
          
            rows.each do |row|
              insert << {
                ref1: row["ref1"],
                ref2: row["ref2"],
                obj_up: row["obj_up"],
                obj_down: row["obj_down"],
              }
            end

            condition =<<~SQL
              t_rem1.ref1 = values_table.ref1
                and t_rem2.ref2 = values_table.ref2
            SQL

            sql = Destination::TRem1.insert_query(rows: insert, condition: condition)
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
