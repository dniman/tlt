namespace :charges do
  namespace :destination do
    namespace :___charge_save do

      task :update_corr_n1 do |t|
        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_corr[:link],
            Destination.s_corr[:sname],
          ])
          manager.from(Destination.s_corr)
          manager.where(Destination.s_corr[:object].eq(Destination::SCorr::DICTIONARY_CORR))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___charge_save set 
              ___charge_save.corr_n1 = values_table.sname
            from ___charge_save
              join (
                #{ query }
              ) values_table(link, sname) on values_table.link = ___charge_save.___corr1
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
