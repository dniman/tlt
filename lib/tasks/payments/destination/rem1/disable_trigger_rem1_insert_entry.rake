namespace :payments do
  namespace :destination do
    namespace :rem1 do

      task :disable_trigger_rem1_insert_entry do |t|
        def query
          <<~QUERY
            disable trigger rem1_insert_entry on rem1
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
