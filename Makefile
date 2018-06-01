OUTPUT=./public
COMMENT=$(shell git log -1 --oneline)
GENERATEDDIR=../emiguelt-generated

build:
	hugo

clean:
	rm -rf $(OUTPUT)

deploy: clean	build
	cp -r $(OUTPUT)/* $(GENERATEDDIR)
	cd $(GENERATEDDIR);\
	echo $(COMMENT);\
	git add .;\
	git commit -m "$(COMMENT)";\
	git push origin master
