namespace :destination do
  namespace :___del_ids do
  
    task :create_table do
      sql = <<~SQL
        create table ___del_ids(
          table_id bigint
          ,id bigint
          ,link bigint
          ,link_type bigint
          ,row_id uniqueidentifier
        )
        if not exists(select * from sys.indexes where name = 'ix___del_ids_table_id_id' and object_id = object_id('___del_ids'))
        create nonclustered index [ix___del_ids_table_id_id] on [dbo].[___del_ids] ([table_id], [id] asc)
        
        if not exists(select * from sys.indexes where name = 'ix___del_ids_table_id_link_type' and object_id = object_id('___del_ids'))
        create nonclustered index [ix___del_ids_table_id_link_type] on [dbo].[___del_ids] ([table_id], [link_type]) include(id, row_id)

        if not exists(select * from sys.indexes where name = 'ix___del_ids_row_id' and object_id = object_id('___del_ids'))
        create nonclustered index [ix___del_ids_row_id] on [dbo].[___del_ids]([row_id])
      SQL
      
      unless Destination.table_exists?('___del_ids')
        begin  
          Destination.execute_query(sql).do

          Rake.info "Таблица '___del_ids' в базе данных '#{ Database.config['destination']['database'] }' успешно создана."
        rescue StandardError => e
          Rake.error "Ошибка при создании таблицы '___del_ids' в базе данных '#{ Database.config['destination']['database'] }' - #{e}."

          exit
        end
      else
        Rake.info "Таблица '___del_ids' в базе данных '#{ Database.config['destination']['database'] }' уже существует."
      end
    end
  end 
end
