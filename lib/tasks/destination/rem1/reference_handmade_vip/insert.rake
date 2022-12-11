namespace :destination do
  namespace :rem1 do
    namespace :reference_handmade_vip do
    
      task :insert do
        
        def entry_query
          Destination.entry
          .project(Destination.entry[:row_id])
          .where(Destination.entry[:object].eq(Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')))
          .take(1)
        end

        def insert_rem1!
          object = Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')
          entry = Destination.execute_query(entry_query.to_sql).entries.first["row_id"]

          manager = Arel::InsertManager.new Database.destination_engine
          manager.insert([
            [Destination.rem1[:object], Arel.sql("#{object}")],
            [Destination.rem1[:row_id], Arel.sql("'#{entry}'")]
          ])
          manager.into(Destination.rem1)
          
          Destination.execute_query(manager.to_sql).do
        end

        def query
          Destination.rem1
          .project(Destination.rem1[:link])
          .where(Destination.rem1[:object].eq(Destination::SObjects.obj_id('REFERENCE_HANDMADE_VIP')))
        end

        result = Destination.execute_query(query.to_sql).entries
        if result.empty?
          begin  
            insert_rem1!

            Rake.info "Объект 'REFERENCE_HANDMADE_VIP' в таблице Rem1 базы данных '#{ Database.config['destination']['database'] }' успешно создан."
          rescue StandardError => e
            Rake.error "Ошибка при создании объекта 'REFERENCE_HANDMADE_VIP' в таблице Rem1 базы данных '#{ Database.config['destination']['database'] }' - #{e}."

            exit
          end
        else
          Rake.info "Объект 'REFERENCE_HANDMADE_VIP' в таблице Rem1 в базе данных '#{ Database.config['destination']['database'] }' уже существует."
        end
      end
    
    end
  end
end
