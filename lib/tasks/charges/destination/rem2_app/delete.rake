namespace :charges do
  namespace :destination do
    namespace :rem2_app do

      task :delete do |t|
        def query
          <<~QUERY
            delete rem2_app
            from ___charge_save
              join rem2 on rem2.row_id = ___charge_save.row_id
              join rem2_app on rem2_app.link_up = rem2.link
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
