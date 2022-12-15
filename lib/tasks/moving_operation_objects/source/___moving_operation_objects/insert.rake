namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :insert do |t|
        def query
          # not exists
          subquery = Arel::SelectManager.new Database.source_engine
          subquery.project(Arel.star)
          subquery.from(Source.___moving_operation_objects)
          subquery.where(
            Source.___moving_operation_objects[:___moving_operation_id].eq(Source.___moving_operations[:id])
            .and(Source.___moving_operation_objects[:object_id].eq(Source.moveitems[:object_id]))
            .and(Source.___moving_operation_objects[:objectusing_id].eq(Source.objectusing[:id]))
            .and(Source.___moving_operation_objects[:___paycardobject_id].eq(Source.___paycardobjects[:id]))
          )


          select_manager = Arel::SelectManager.new Database.source_engine
          select_manager.project(
            Source.___moving_operations[:id].as("___moving_operation_id"),
            Source.moveitems[:object_id],
            Source.objectusing[:id].as("objectusing_id"),
            Source.___paycardobjects[:id].as("___paycardobject_id"),
            Source.___paycards[:summa2],
            Source.___paycardobjects[:share_size],
            Source.___paycardobjects[:numerator],
            Source.___paycardobjects[:denominator],
            Source.___paycardobjects[:area1],
            Source.___paycardobjects[:part_num],
            Source.___paycardobjects[:part_name],
            Source.___paycardobjects[:func_using_id],
          )
          select_manager.from(Source.moveitems)
          select_manager.join(Source.___moving_operations).on(Source.___moving_operations[:moveitem_id].eq(Source.moveitems[:id]))
          select_manager.join(Source.objectusing, Arel::Nodes::OuterJoin).on(Source.objectusing[:moveitem_id].eq(Source.moveitems[:id]))
          select_manager.join(Source.___paycardobjects, Arel::Nodes::OuterJoin).on(
            Source.___paycardobjects[:moveitem_id].eq(Source.moveitems[:id])
            .and(Source.___paycardobjects[:object_id].eq(Source.moveitems[:object_id]))
            .and(Source.___paycardobjects[:objectusing_id].eq(Source.objectusing[:id]))
          )
          select_manager.join(Source.___paycards, Arel::Nodes::OuterJoin).on(Source.___paycards[:id].eq(Source.___paycardobjects[:___paycard_id]))
          select_manager.where(subquery.exists.not)
          
          source = Arel::Nodes::JoinSource.new(select_manager,[])

          insert_manager = Arel::InsertManager.new Database.source_engine
          insert_manager.columns << Source.___moving_operation_objects[:___moving_operation_id] 
          insert_manager.columns << Source.___moving_operation_objects[:object_id]
          insert_manager.columns << Source.___moving_operation_objects[:objectusing_id]
          insert_manager.columns << Source.___moving_operation_objects[:___paycardobject_id]
          insert_manager.columns << Source.___moving_operation_objects[:summa2]
          insert_manager.columns << Source.___moving_operation_objects[:share_size]
          insert_manager.columns << Source.___moving_operation_objects[:numerator]
          insert_manager.columns << Source.___moving_operation_objects[:denominator]
          insert_manager.columns << Source.___moving_operation_objects[:area1]
          insert_manager.columns << Source.___moving_operation_objects[:part_num]
          insert_manager.columns << Source.___moving_operation_objects[:part_name]
          insert_manager.columns << Source.___moving_operation_objects[:func_using_id]
          insert_manager.into(Source.___moving_operation_objects)
          insert_manager.select(source)
          insert_manager.to_sql
        end

        begin
          Source.execute_query(query).do

          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ query }\""

          exit
        end
      end

    end
  end
end
