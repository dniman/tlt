namespace :payments do
  namespace :source do
    namespace :payments do

      task :update___income_code do |t|
        def query
          manager = Arel::SelectManager.new Database.source_engine
          manager.project(
            Source.cls_kbk[:id].as("cls_kbk_id"),
            Source.cls_kbk[:name].as("___income_code"),
          )
          manager.from(Source.cls_kbk)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update payments set 
              payments.___income_code = values_table.___income_code
            from payments
              join(
                #{ query }
              ) values_table(cls_kbk_id, ___income_code) on values_table.cls_kbk_id = payments.cls_kbk_id
          SQL
          
          Source.execute_query(sql).do
          
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
