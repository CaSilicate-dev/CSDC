aaa:
	npm run build
	ssh mys 'rm -rf /srv/csdc'
	ssh mys 'mkdir -p /srv/csdc'
	scp -r dist/* mys:/srv/csdc
.PHONY: aaa