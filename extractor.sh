docker run -it  \
  #-v "$(pwd):/binwalk" \
  #-w /binwalk 
  --name extractor \
  extractor:latest \
  #--run-as=root \
  /bin/bash \
  "$@"
  
  
