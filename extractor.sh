docker run -it  \
  #-v "$(pwd):/extractor" \
  #-w /binwalk 
  --name extractor \
  extractor:local \
  #--run-as=root \
  /bin/bash \
  "$@"
  
  
