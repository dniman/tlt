namespace :source do
  namespace :___ids do
  
    task :create_table do
      sql = <<~SQL
        create table ___ids(
          table_id bigint
          ,id bigint
          ,link bigint
          ,link_type bigint
          ,row_id uniqueidentifier
        )
        if not exists(select * from sys.indexes where name = 'ix____ids_table_id_id' and object_id = object_id('___ids'))
        create nonclustered index [ix____ids_table_id_id] on [dbo].[___ids] ([table_id], [id] asc)
        
        if not exists(select * from sys.indexes where name = 'ix____ids_table_id_link_type' and object_id = object_id('___ids'))
        create nonclustered index [ix____ids_table_id_link_type] on [dbo].[___ids] ([table_id], [link_type]) include(id, row_id)

        if not exists(select * from sys.indexes where name = 'ix____ids_row_id' and object_id = object_id('___ids'))
        create nonclustered index [ix____ids_row_id] on [dbo].[___ids]([row_id])
      SQL
      
      unless Source.table_exists?('___ids')
        begin  
          Source.execute_query(sql).do

          Rake.info "Таблица '___ids' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
        rescue StandardError => e
          Rake.error "Ошибка при создании таблицы '___ids' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
        end
      else
        Rake.info "Таблица '___ids' в базе данных '#{ Database.config['source']['database'] }' уже существует."
      end
    end
  end 
end
