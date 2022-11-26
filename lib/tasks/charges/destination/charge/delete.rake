namespace :charges do
  namespace :destination do
    namespace :charge do

      task :delete do |t|
        def query
          <<~QUERY
            delete charge
            from charge
              join ___charge_save on ___charge_save.row_id = charge.row_id
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
