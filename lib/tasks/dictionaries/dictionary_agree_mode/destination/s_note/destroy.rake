namespace :dictionaries do
  namespace :dictionary_agree_mode do
    namespace :destination do
      namespace :s_note do

        task :delete do |t|
          begin
            subquery = 
              Destination.s_note
              .project(Destination.s_note[:link])
              .distinct
              .where(Destination.s_note[:object].eq(Destination::SObjects.obj_id('DICTIONARY_AGREE_MODE')))

            manager = Arel::DeleteManager.new(Database.destination_engine)
            manager.from (Destination.s_note)
            manager.where(Arel::Nodes::In.new(Destination.s_note[:link],subquery))

            Destination.execute_query(manager.to_sql).do
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
end
