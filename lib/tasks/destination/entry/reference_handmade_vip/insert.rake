namespace :destination do
  namespace :entry do
    namespace :reference_handmade_vip do
    
      task :insert do
        def insert_entry!
          object = Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')

          manager = Arel::InsertManager.new Database.destination_engine
          manager.insert([
            [Destination.entry[:object], Arel.sql("#{object}")],
            [Destination.entry[:row_id], Arel.sql('newid()')]
          ])
          manager.into(Destination.entry)
        
          Destination.execute_query(manager.to_sql).do
        end
          
        def query
          Destination.entry
          .project(Destination.entry[:link])
          .where(Destination.entry[:object].eq(Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')))
        end

        result = Destination.execute_query(query.to_sql).entries
        if result.empty?
          begin  
            insert_entry!

            Rake.info "Объект 'REFERENCE_HANDMADE_VIP' в таблице Entry базы данных '#{ Database.config['destination']['database'] }' успешно создан."
          rescue StandardError => e
            Rake.error "Ошибка при создании объекта 'REFERENCE_HANDMADE_VIP' в таблице Entry базы данных '#{ Database.config['destination']['database'] }' - #{e}."

            exit
          end
        else
          Rake.info "Объект 'REFERENCE_HANDMADE_VIP' в таблице Entry в базе данных '#{ Database.config['destination']['database'] }' уже существует."
        end
      end
    
    end
  end
end
