namespace :moving_operation_objects do
  namespace :destination do
    namespace :mss_moves_mss_objects do

      task :insert do |t|

        def query
          Source.___moving_operations
          .project([
            Source.___moving_operations[:___link_key].as("link_key"),
            Source.___ids[:link_type],
            Source.___ids[:row_id],
            Source.___moving_operations[:sincedate].as("date_beg"),
            Source.___moving_operations[:enddate].as("date_end"),
            Source.___moving_operations[:sincedate].as("date_mov"),
            Source.___moving_operations[:___link_corr].as("link_corr"),
            num_reg.as("num_reg"),
            date_reg.as("date_reg"),
            Source.___moving_operations[:___link_cause_b].as("link_cause_b"),
            Source.___moving_operations[:___link_cause_e].as("link_decomm_cause"),
            Arel.sql("#{ Destination::MssOacRowstates::CURRENT }").as("link_scd_state")
          ])
          .join(Source.___ids).on(Source.___ids[:id].eq(Source.___moving_operations[:id]).and(Source.___ids[:table_id].eq(Source::MovingOperations.table_id)))
          .where(Source.___ids[:link_type].not_eq(nil))
        end
        
        begin
          sql = ""
          selects = [] 
          unions = []

          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              Arel::SelectManager.new.tap do |select|
                selects <<
                  select.project([
                    Arel::Nodes::Quoted.new(row["link_key"]),
                    Arel::Nodes::Quoted.new(row["link_type"]),
                    Arel::Nodes::Quoted.new(row["row_id"]),
                    Arel::Nodes::Quoted.new(row["date_beg"].nil? ? nil : row["date_beg"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["date_end"].nil? ? nil : row["date_end"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["date_mov"].nil? ? nil : row["date_mov"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["link_corr"]),
                    Arel::Nodes::Quoted.new(row["num_reg"]),
                    Arel::Nodes::Quoted.new(row["date_reg"].nil? ? nil : row["date_reg"].strftime("%Y%m%d")),
                    Arel::Nodes::Quoted.new(row["link_cause_b"]),
                    Arel::Nodes::Quoted.new(row["link_decomm_cause"]),
                    Arel::Nodes::Quoted.new(row["link_scd_state"]),
                  ])
              end
            end  
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new(Database.destination_engine).tap do |manager|
              rows.first.keys.each do |column|
                manager.columns << Destination.mss_movs[column.to_sym]
              end
              manager.into(Destination.mss_movs)
              manager.select(unions.last)
            end
            sql = insert_manager.to_sql
          
            #sql = Destination::MssMovs.insert_query(rows: insert, condition: "mss_movs.row_id = values_table.row_id")
            result = Destination.execute_query(sql)
            result.do
            selects.clear
            unions.clear
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
