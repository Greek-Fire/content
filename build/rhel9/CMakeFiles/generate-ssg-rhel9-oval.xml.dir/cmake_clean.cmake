file(REMOVE_RECURSE
  "../ssg-rhel9-oval.xml"
  "CMakeFiles/generate-ssg-rhel9-oval.xml"
  "checks/sce/metadata.json"
  "collect-remediations-rhel9"
  "oval-unlinked.xml"
  "product.yml"
  "ssg-rhel9-ocil.xml"
  "ssg-rhel9-oval.xml"
  "ssg-rhel9-xccdf.xml"
  "ssg_build_compile_all-rhel9"
  "templated-content-rhel9"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/generate-ssg-rhel9-oval.xml.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
