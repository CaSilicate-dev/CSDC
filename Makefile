aaa:
	npm run build
	scp -r dist/* mys:/srv/csdc
.PHONY: aaa