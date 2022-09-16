namespace :objects do
  namespace :construction do
    namespace :destroy do
      task :tasks => [
        'objects:construction:destination:mss_objects:delete',
        'objects:construction:destination:mss_objects:drop___cad_quorter',
        'objects:construction:destination:mss_objects:drop___kadastrno',
        'objects:construction:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:construction:destination:mss_objects_adr:delete',
        'objects:construction:source:ids:drop___link_adr',
        'objects:construction:destination:mss_adr:delete',
      ]
    end
  end
end
