namespace :destination do
  namespace :s_note do
    namespace :object do
      namespace :completed_tasks do
        
        task :insert do
          link = Destination::SObjects.obj_id('COMPLETED_TASKS')

          unless link
            begin  
              sql =<<~SQL
                -- Создание нового объекта
                exec dbo.stru_edit_objects @cObjCode='COMPLETED_TASKS', @cObjName='Завершенные задачи', @nMode=3
                exec dbo.stru_add_property @cParentObjCode='COMPLETED_TASKS', @cObjCode='CLASS_REFERENCE', @nContainer=0
                exec dbo.stru_add_property @cParentObjCode='OTHER_CATALOG', @cObjCode='COMPLETED_TASKS', @nContainer=1
                -- Окончание создания нового объекта
              SQL

              Destination.execute_query(sql).do

              Rake.info "Объект 'COMPLETED_TASKS' в базе данных '#{ Database.config['destination']['database'] }' успешно создан."
            rescue StandardError => e
              Rake.error "Ошибка при создании объекта 'COMPLETED_TASKS' в базе данных '#{ Database.config['destination']['database'] }' - #{e}."
            end
          else
            Rake.info "Объект 'COMPLETED_TASKS' в базе данных '#{ Database.config['destination']['database'] }' уже существует."
          end
        end

      end
    end
  end
end
