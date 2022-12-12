namespace :charges do
  namespace :destination do
    namespace :___charge_save do

      task :update_inc do |t|
        def query
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.s_kbk[:link],
            Destination.s_kbk[:code],
          ])
          manager.from(Destination.s_kbk)
          manager.where(Destination.s_kbk[:object].eq(Destination::SKbk::DICTIONARY_KBK_INC))
          manager.to_sql
        end

        begin
          sql = <<~SQL
            update ___charge_save set 
              ___charge_save.inc = values_table.link
            from ___charge_save
              join (
                #{ query }
              ) values_table(link, code) on values_table.code = ___charge_save.___cinc
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
