cf-validate:
	aws cloudformation validate-template --template-body file:///$(CURDIR)/cloudformation.json
