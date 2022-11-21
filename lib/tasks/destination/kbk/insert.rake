namespace :destination do
  namespace :kbk do
  
    task :insert do
      def query
        Destination.s_kbk
        .project(Destination.s_kbk[:link])
        .where(Destination.s_kbk[:code].eq(Arel.sql("'нар/счетб/д0000000'")))
      end

      row = Destination.execute_query(query.to_sql).entries
      link = row.empty? ? nil : row.first["link"]

      unless link
        begin  
          sql =<<~SQL
            declare @out table(link int)
            insert into dbo.s_kbk(code,object,row_id) output inserted.link into @out
            select 'нар/счетб/д0000000', 
                dbo.obj_id('DICTIONARY_KBK_INC'), 
                newid()

            insert into s_kbk_name(link_up, name, sname)
            select link, 'Условный КБК', 'Условный КБК'
            from @out
          SQL

          Destination.execute_query(sql).do

          Rake.info "'Условный КБК' в базе данных '#{ Database.config['destination']['database'] }' успешно создан."
        rescue StandardError => e
          Rake.error "Ошибка при создании 'Условный КБК' в базе данных '#{ Database.config['destination']['database'] }' - #{e}."
        end
      else
        Rake.info "'Условный КБК' в базе данных '#{ Database.config['destination']['database'] }' уже существует."
      end
    end
  
  end
end
