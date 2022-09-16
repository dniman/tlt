namespace :objects do
  namespace :unfinished do
    namespace :destroy do
      task :tasks => [
        'objects:unfinished:destination:mss_objects:delete',
        'objects:unfinished:destination:mss_objects:drop___cad_quorter',
        'objects:unfinished:destination:mss_objects:drop___kadastrno',
        'objects:unfinished:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:unfinished:destination:mss_objects_adr:delete',
        'objects:unfinished:source:ids:drop___link_adr',
        'objects:unfinished:destination:mss_adr:delete',
      ]
    end
  end
end
