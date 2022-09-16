namespace :objects do
  namespace :houses_unlife do
    namespace :destroy do
      task :tasks => [
        'objects:houses_unlife:destination:mss_objects:delete',
        'objects:houses_unlife:destination:mss_objects:drop___cad_quorter',
        'objects:houses_unlife:destination:mss_objects:drop___kadastrno',
        'objects:houses_unlife:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:houses_unlife:destination:mss_objects_adr:delete',
        'objects:houses_unlife:source:ids:drop___link_adr',
        'objects:houses_unlife:destination:mss_adr:delete',
      ]
    end
  end
end
