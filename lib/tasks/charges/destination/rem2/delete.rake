namespace :charges do
  namespace :destination do
    namespace :rem2 do

      task :delete do |t|
        def query
          <<~QUERY
            delete rem2
            from ___charge_save
              join rem2 on rem2.row_id = ___charge_save.row_id
          QUERY
        end

        begin
          Destination.execute_query(query).do
          
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
