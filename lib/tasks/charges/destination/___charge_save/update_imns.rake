namespace :charges do
  namespace :destination do
    namespace :___charge_save do
      
      task :update_imns do |t|
        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_baccount[:corr],
            Destination.s_baccount[:link],
          ])
          manager.from(Destination.s_baccount)
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___charge_save set 
              ___charge_save.imns = values_table.corr
            from ___charge_save
              join (
                #{ query }
              ) values_table(corr, link) on values_table.link = ___charge_save.acc
          SQL

          Destination.execute_query(sql).do
          
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
