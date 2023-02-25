namespace :moving_operation_objects do
  namespace :source do
    namespace :___moving_operation_objects do

      task :update___link_rp do |t|

        def link_rp(name)
          manager = Arel::SelectManager.new(Database.destination_engine)
          manager.project([
            Destination.mss_reestr_partitions[:link],
          ])
          manager.from(Destination.mss_reestr_partitions)
          manager.where(Destination.mss_reestr_partitions[:name].eq(name))
          Destination.execute_query(manager.to_sql).entries.first["link"]
        end

        def query(object_type_name, name)
          manager = Arel::UpdateManager.new(Database.source_engine)
          manager.table(Source.___moving_operation_objects)
          manager.set([[Source.___moving_operation_objects[:___link_rp], link_rp(name)]])
          manager.where(Source.___moving_operation_objects[:___object_type_name].eq(object_type_name))
          manager.to_sql
        end

        begin
          queries = []
          queries << query('Здание', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Нежилое помещение', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Единый недвижимый комплекс', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Воздушное судно', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Морское судно', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Судно внутреннего плавания', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Нежилое здание', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Имущественный комплекс', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Рекламные конструкции', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Движимое сооружение', 'РЕЕСТР ОБЪЕКТОВ НЕДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Земельный участок', 'ЗЕМЕЛЬНЫЕ УЧАСТКИ')
          queries << query('Сооружение', 'ОБЪЕКТЫ ИНЖЕНЕРНОЙ ИНФРАСТРУКТУРЫ')
          queries << query('Инженерная сеть', 'ОБЪЕКТЫ ИНЖЕНЕРНОЙ ИНФРАСТРУКТУРЫ')
          queries << query('Автомобильная дорога', 'АВТОМОБИЛЬНЫЕ ДОРОГИ')
          queries << query('Жилое помещение', 'ОБЪЕКТЫ ЖИЛИЩНОГО ФОНДА')
          queries << query('Жилое здание', 'ОБЪЕКТЫ ЖИЛИЩНОГО ФОНДА')
          queries << query('Объект незавершенного строительства', 'ОБЪЕКТЫ НЕЗАВЕРШЕННОГО СТРОИТЕЛЬСТВА')
          queries << query('Транспортное средство', 'ОБЪЕКТЫ ДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Иное движимое имущество', 'ОБЪЕКТЫ ДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Материальные запасы', 'ОБЪЕКТЫ ДВИЖИМОГО ИМУЩЕСТВА')
          queries << query('Доля (вклад) в уставном (складочном) капитале', 'АКЦИИ (ДОЛИ, ВКЛАДЫ)')
          queries << query('Акции', 'АКЦИИ (ДОЛИ, ВКЛАДЫ)')
          queries << query('Объекты интеллектуальной собственности', 'ИСКЛЮЧИТЕЛЬНЫЕ ПРАВА НА ПРОГРАММЫ ЭВМ')

          sql = ""
          queries.each do |query| 
            sql = query
            Source.execute_query(sql).do
          end
          
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
