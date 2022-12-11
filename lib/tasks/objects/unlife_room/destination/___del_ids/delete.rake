namespace :objects do
  namespace :unlife_room do
    namespace :destination do
      namespace :___del_ids do

        task :delete do |t|
          def query
            manager = Arel::DeleteManager.new Database.destination_engine
            manager.from(Destination.___del_ids)
            manager.where(Destination.___del_ids[:table_id].eq(Source::Objects.table_id))
            manager.to_sql
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
end
