namespace :source do
  namespace :ids do
  
    task :create_table do
      sql = <<~SQL
        create table ids(
          table_id bigint
          ,id bigint
          ,link bigint
          ,link_type bigint
          ,row_id uniqueidentifier
        )
        if not exists(select * from sys.indexes where name = 'ix_ids_table_id_id' and object_id = object_id('ids'))
        create nonclustered index [ix_ids_table_id_id] on [dbo].[ids] ([table_id], [id] asc)
        
        if not exists(select * from sys.indexes where name = 'ix_ids_table_id_link_type' and object_id = object_id('ids'))
        create nonclustered index [ix_ids_table_id_link_type] on [dbo].[ids] ([table_id], [link_type]) include(id, row_id)
      SQL
      
      unless Source.table_exists?('ids')
        begin  
          Source.execute_query(sql).do

          Rake.info "Таблица 'ids' в базе данных '#{ Database.config['source']['database'] }' успешно создана."
        rescue StandardError => e
          Rake.error "Ошибка при создании таблицы 'ids' в базе данных '#{ Database.config['source']['database'] }' - #{e}."
        end
      else
        Rake.info "Таблица 'ids' в базе данных '#{ Database.config['source']['database'] }' уже существует."
      end
    end
  end 
end
