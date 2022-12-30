docker run --rm -t -i --tmpfs /tmp:rw,size=${mem} \
  -v "$(pwd):/extractor" \
  -w /extractor \
   "ddcc/firmadyne-extractor:latest" \
  #--name extractor \
	#--run-as=root \
  "$@" 
  
  
