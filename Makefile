OUTPUT=./output
COMMENT=$(shell git log -1 --oneline)
co:
	nanoc co
	cp -r ./static/* $(OUTPUT)/ -u

clean:
	rm -rf $(OUTPUT)

deploy: clean	co
	cp -r $(OUTPUT)/* ../emiguelt/
	cd ../emiguelt/
	echo $(COMMENT)
	git add .
	git commit -m $(COMMENT)
	git push origin master
