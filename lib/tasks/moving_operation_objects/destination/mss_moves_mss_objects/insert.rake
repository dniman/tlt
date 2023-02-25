namespace :moving_operation_objects do
  namespace :destination do
    namespace :mss_moves_mss_objects do

      task :insert do |t|
        def query
          moving_operations = Source.___ids.alias("moving_operations")
          objs = Source.___ids.alias("objs")
          paycardobjects = Source.___ids.alias("paycardobjects")
          nazn = Source.___ids.alias("nazn")

          is_share =
            Arel::Nodes::Case.new
            .when(Source.___moving_operation_objects[:share_size].not_eq(nil)).then(1)
            .else(0)
          
          manager = Arel::SelectManager.new Database.source_engine
          manager.project([
            moving_operations[:link].as("link_move"),
            objs[:link].as("link_object"),
            Source.___moving_operation_objects[:___link_rp].as("link_rp"),
            Source.objects[:regno].as("r_num"),
            paycardobjects[:link].as("link_pco"),
            Source.___moving_operation_objects[:summa2].as("agr_summa"),
            is_share.as("is_share"),
            Source.___moving_operation_objects[:numerator].as("numerator_share"),
            Source.___moving_operation_objects[:denominator].as("denumerator_share"),
            Source.___moving_operation_objects[:area1].as("area_share"),
            Source.___moving_operation_objects[:part_num].as("num_share"),
            Source.___moving_operation_objects[:part_name].as("name_share"),
            nazn[:link].as("agr_nazn"),
            Source.___moving_operation_objects[:___is_change_reestr].as("is_change_reestr"),
            Source.___moving_operation_objects[:___is_excl_from_r].as("is_excl_from_r"),
            Source.___ids[:row_id],
          ])
          manager.from(Source.___moving_operation_objects)
          manager.join(moving_operations).on(
            moving_operations[:id].eq(Source.___moving_operation_objects[:___moving_operation_id])
            .and(moving_operations[:table_id].eq(Source::MovingOperations.table_id))
          )
          manager.join(objs).on(
            objs[:id].eq(Source.___moving_operation_objects[:object_id])
            .and(objs[:table_id].eq(Source::Objects.table_id))
          )
          manager.join(Source.objects).on(Source.objects[:id].eq(Source.___moving_operation_objects[:object_id]))
          manager.join(paycardobjects, Arel::Nodes::OuterJoin).on(
            paycardobjects[:id].eq(Source.___moving_operation_objects[:___paycardobject_id])
            .and(paycardobjects[:table_id].eq(Source::Paycardobjects.table_id))
          )
          manager.join(Source.___ids).on(
            Source.___ids[:id].eq(Source.___moving_operation_objects[:id])
            .and(Source.___ids[:table_id].eq(Source::MovingOperationObjects.table_id))
          )
          manager.join(nazn, Arel::Nodes::OuterJoin).on(nazn[:id].eq(Source.___moving_operation_objects[:func_using_id]).and(nazn[:table_id].eq(Source::FuncUsing.table_id)))
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
                    Arel::Nodes::Quoted.new(row["link_move"]),
                    Arel::Nodes::Quoted.new(row["link_object"]),
                    Arel::Nodes::Quoted.new(row["link_rp"]),
                    Arel::Nodes::Quoted.new(row["r_num"].nil? ? nil : row["r_num"].strip[0..49]),
                    Arel::Nodes::Quoted.new(row["link_pco"]),
                    Arel::Nodes::Quoted.new(row["agr_summa"]),
                    Arel::Nodes::Quoted.new(row["is_share"]),
                    Arel::Nodes::Quoted.new(row["numerator_share"]),
                    Arel::Nodes::Quoted.new(row["denumerator_share"]),
                    Arel::Nodes::Quoted.new(row["area_share"]),
                    Arel::Nodes::Quoted.new(row["num_share"]),
                    Arel::Nodes::Quoted.new(row["name_share"]),
                    Arel::Nodes::Quoted.new(row["agr_nazn"].nil? ? nil : row["agr_nazn"].to_s.strip[0..999]),
                    Arel::Nodes::Quoted.new(row["is_change_reestr"]),
                    Arel::Nodes::Quoted.new(row["is_excl_from_r"]),
                    Arel::Nodes::Quoted.new(row["row_id"]),
                  ])
              end
            end  
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new(Database.destination_engine).tap do |manager|
              rows.first.keys.each do |column|
                manager.columns << Destination.mss_moves_mss_objects[column.to_sym]
              end
              manager.into(Destination.mss_moves_mss_objects)
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
